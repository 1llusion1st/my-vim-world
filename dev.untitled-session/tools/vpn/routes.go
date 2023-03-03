package vpn

type Routes []string

func (r *Routes) AsOpenVPNRoutes() []string {
	res := make([]string, 0)
	for _, route := range *r {
		res = append(res, "--route", route, "255.255.255.255")
	}
	return res
}
