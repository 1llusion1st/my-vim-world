package vpn

import (
	"context"
	"fmt"
	"os/exec"
	"strconv"
	"strings"
)

type OAuthToolAPI struct {
	Code string
}

func (o *OAuthToolAPI) GetCode(ctx context.Context) (string, error) {
	o.Code = strings.Trim(o.Code, "\r\n")
	out, err := exec.Command("oathtool", strings.Split(fmt.Sprintf("-b --totp %s", o.Code), " ")...).Output()
	if err != nil {
		return "", fmt.Errorf("error while executing oathtool: %v", err)
	}
	code := strings.Replace(string(out), "\n", "", -1)
	_, err = strconv.Atoi(code)
	if err != nil {
		return "", err
	}
	if len(code) != 6 {
		return "", fmt.Errorf("wrong code: '%s'", code)
	}
	return code, nil
}
