# Readme
Quick and dirty setup for Raspberry Pi Access Point and server.

## Access Point
Run the following commands:
git clone https://github.com/Nick-Henkey/rpi-access-point/
chmod +x rpi-access-point/*.sh
./rpi-access-point/raspberry-pi-hotspot.sh

If the access point is down, try running `sudo nmcli connection up Hotspot`

To ensure it starts on every boot, do the following:

`sudo crontab -e`
Add a line that says the following:

`@reboot sudo nmcli connection up Hotspot`

## VPN script
The VPN script will set up a VPN tunnel for all connected devices. Access Point is required before running the following command:

./rpi-access-point/vpn-setup.sh

If the VPN is down, try running `sudo openvpn --config "/etc/openvpn/client/vpn-server.conf" --auth-nocache`. This will start it up but take over your terminal session and will exit when you close the window.

I prefer to run this in cronntab as well, by running:
`sudo crontab -e`
Add a line that says the following:
`@reboot sudo openvpn --config "/etc/openvpn/client/vpn-server.conf" --auth-nocache`

