========
OVPN configuration
	The correct configuration for OpenVpn is:
	https://superuser.com/a/628488 

	route-nopull 
	route 192.168.0.0 255.255.255.0
	These entries belong in your .ovpn file and will direct all 192.168.0.* subnet traffic through the VPN.

	For one IP only (192.168.0.1):

	route-nopull 
	route 192.168.0.1 255.255.255.255
	BTW: route-nopull means "don't pull routes from the server"

==
GA

	https://github.com/arcanericky/ga-cmd
