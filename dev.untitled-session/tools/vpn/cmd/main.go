package main

import (
	"context"
	"fmt"
	"os"
	"strings"
	"tools/vpn"

	tea "github.com/charmbracelet/bubbletea"
)

func main() {
	dir := "dev/vpns"
	if len(os.Args) == 2 {
		dir = os.Args[1]
	}
	vpns, err := vpn.ReadConfiguration(context.Background(), dir)
	if err != nil {
		panic(err)
	}
	p := tea.NewProgram(initialModel(vpns), tea.WithAltScreen())
	if _, err := p.Run(); err != nil {
		fmt.Printf("Alas, there's been an error: %v", err)
		os.Exit(1)
	}

}

func initialModel(vpns *vpn.VPNsConfig) model {
	return model{
		vpns:   vpns,
		index:  0,
		active: make(map[int]bool),
	}
}

type model struct {
	vpns   *vpn.VPNsConfig
	index  int
	active map[int]bool
}

// Init is the first function that will be called. It returns an optional
// initial command. To not perform an initial command return nil.
func (m model) Init() tea.Cmd {
	return nil
}

// Update is called when a message is received. Use it to inspect messages
// and, in response, update the model and/or send a command.
func (m model) Update(msg_ tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg_.(type) {
	case tea.KeyMsg:
		{
			switch msg.String() {
			case "ctrl+c":
				{
					for _, vpn := range m.vpns.VPNs {
						if vpn.Active() {
							vpn.Down(context.Background())
						}
					}
					return m, tea.Quit
					break
				}
			case "up", "k":
				{
					if m.index > 0 {
						m.index -= 1
					}
				}
			case "down", "j":
				{
					if m.index < len(m.vpns.VPNs)-1 {
						m.index += 1
					}
				}
			case "enter", " ":
				{
					if m.vpns.VPNs[m.index].Active() {
						m.vpns.VPNs[m.index].Down(context.Background())
						m.active[m.index] = false
					} else {
						m.vpns.VPNs[m.index].Up(context.Background())
						m.active[m.index] = true
					}
				}
			}
		}
	}
	return m, nil
}

// View renders the program's UI, which is just a string. The view is
// rendered after every Update.
func (m model) View() string {
	lines := make([]string, 0)
	lines = append(lines, "VPNS:")
	for i, vpn := range m.vpns.VPNs {
		line := " ["
		current := m.index == i
		if current {
			line = ">["
		}
		active := vpn.Active()
		if active {
			line = line + "+] "
		} else {
			line = line + " ]"
		}

		line = line + vpn.Name
		lines = append(lines, line)
	}
	return strings.Join(lines, "\n")
}
