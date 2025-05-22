package vpn

import (
	"context"
	"fmt"
	"io/ioutil"
	"net"
	"os"
	"os/exec"
	"path"
	"strings"
	"sync"
	"syscall"
	"time"
)

type Vpn struct {
	Name          string
	File          string
	Routes        Routes
	Dev           string
	PinOrPassword string
	OtpCodeToken  string
	OVPNData      string

	State struct {
		Pid int

		Sym     string
		SymLock *sync.Mutex

		Command *exec.Cmd
		lock    *sync.Mutex
	}
}

func (v *Vpn) SetSym(sym string) {
	v.State.SymLock.Lock()
	defer v.State.SymLock.Unlock()

	v.State.Sym = sym
}

func (v *Vpn) GetSym() string {
	return v.State.Sym
}

func (v *Vpn) SetDone() {
	v.SetSym(" ")
}

func (v *Vpn) SetFailed() {
	v.SetSym("🛑")
}

func (v *Vpn) SetActivating() {
	v.SetSym("🌀")
}

func (v *Vpn) SetEstablished() {
	v.SetSym("✅")
}

func (v *Vpn) GetPassword(ctx context.Context) (string, error) {
	if v.OtpCodeToken != "" {
		otpToken, err := (&OAuthToolAPI{Code: v.OtpCodeToken}).GetCode(ctx)
		if err != nil {
			return "", err
		}
		return v.PinOrPassword + otpToken, nil
	} else {
		return v.PinOrPassword, nil
	}
}

func (v *Vpn) HandleRestart(ctx context.Context) {
	for {
		if v.State.Command != nil {
			err := v.State.Command.Process.Signal(syscall.Signal(0))
			// fmt.Printf("sig err: %v\n", err)
			if err != nil {
				v.Up(ctx)
			}
		}

		time.Sleep(2 * time.Second)
	}
}

func (v *Vpn) Up(ctx context.Context) error {
	// fmt.Println("activating")
	v.State.lock.Lock()
	defer v.State.lock.Unlock()

	v.SetActivating()

	password, err := v.GetPassword(context.Background())
	if err != nil {
		return err
	}
	user := "user"
	f, err := os.CreateTemp("/tmp/", "fasw")
	if err != nil {
		return err
	}
	defer f.Close()
	_, err = f.WriteString(fmt.Sprintf("%s\n%s", user, password))
	if err != nil {
		return err
	}
	// fmt.Println("running openvpn with file: ", v.File)
	args := make([]string, 0)
	args = append(args, "--config", v.File)
	args = append(args, "--auth-user-pass", f.Name())
	args = append(args, "--dev", "tun"+v.Name)
	args = append(args, "--route-nopull")
	args = append(args, v.Routes.AsOpenVPNRoutes()...)
	// fmt.Println("openvpn args: ", strings.Join(args, " "), args)

	v.State.Command = exec.Command("openvpn", args...)
	stdout, err := v.State.Command.StdoutPipe()
	if err != nil {
		return nil
	}

	cmd := v.State.Command

	v.State.Command.Stderr = v.State.Command.Stdout
	err = v.State.Command.Start()
	if err != nil {
		return err
	}

	v.SetEstablished()

	v.State.Pid = v.State.Command.Process.Pid

	go func() {
		tmp := make([]byte, 1024)

		for {
			_, err := stdout.Read(tmp)
			if err != nil {
				break
			}

			// fmt.Println(string(tmp[:n]))
		}
	}()

	go func() {
		cmd.Wait()
		v.SetFailed()
		// fmt.Println("done")
	}()

	// prepare Routes

	return nil
}

func (v *Vpn) Down(ctx context.Context) error {
	v.State.lock.Lock()
	defer v.State.lock.Unlock()

	if v.State.Command == nil {
		return nil
	}
	err := v.State.Command.Process.Signal(os.Kill)
	if err != nil {
		return err
	}
	//	_, err = v.State.Command.Process.Wait()
	//	if err != nil {
	//		return err
	//	}
	v.State.Command = nil

	v.SetDone()

	return nil
}

func (v *Vpn) Active() bool {
	return v.State.Command != nil
}

func ReadVpnConfig(ctx context.Context, dir string) (*Vpn, error) {
	v := &Vpn{Name: path.Base(dir)}
	v.State.lock = new(sync.Mutex)
	v.State.SymLock = new(sync.Mutex)

	dirItems, err := ioutil.ReadDir(dir)

	if err != nil {
		return nil, err
	}
	for _, dirItem := range dirItems {
		data, err := ioutil.ReadFile(dir + "/" + dirItem.Name())
		if err != nil {
			return nil, err
			// continue
		}
		if strings.HasSuffix(strings.ToLower(dirItem.Name()), ".ovpn") {
			v.File = dir + "/" + dirItem.Name()
			v.OVPNData = string(data)
		} else if strings.ToLower(dirItem.Name()) == "pin" || strings.ToLower(dirItem.Name()) == "password" {
			v.PinOrPassword = strings.Trim(string(data), "\r\n")
		} else if strings.ToLower(dirItem.Name()) == "token" {
			v.OtpCodeToken = strings.Trim(string(data), "\r\n")
		} else {
			ip := net.ParseIP(dirItem.Name())
			if ip != nil {
				v.Routes = append(v.Routes, dirItem.Name())
			} else {
				// parse domain and retrive ip
				ips, err := net.LookupIP(dirItem.Name())
				if err != nil {
					return nil, err
					// continue
				}
				for _, ip := range ips {
					if ipv4 := ip.To4(); ipv4 != nil {
						v.Routes = append(v.Routes, ipv4.String())
					}
				}
			}
		}
	}
	return v, nil
}

type VPNsConfig struct {
	VPNs []Vpn
}

func ReadConfiguration(ctx context.Context, dir string) (*VPNsConfig, error) {
	v := &VPNsConfig{}
	v.VPNs = make([]Vpn, 0)

	dirItems, err := ioutil.ReadDir(dir)
	if err != nil {
		return nil, err
	}

	for _, dirItem := range dirItems {
		if dirItem.IsDir() {
			vpnConf, err := ReadVpnConfig(ctx, dir+"/"+dirItem.Name())
			if err != nil {
				return nil, err
			}
			v.VPNs = append(v.VPNs, *vpnConf)
		}
	}
	return v, nil
}

func init() {
	//	fmt.Println("init vpn ....")
	//	openvpn3.SelfCheck(logger)
}
