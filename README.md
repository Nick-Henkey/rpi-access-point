# Readme
Quick and dirty setup for Raspberry Pi Access Point and VPN router.

## Access Point
Run the following commands:

`git clone https://github.com/Nick-Henkey/rpi-access-point/`

`chmod +x rpi-access-point/*.sh`

`./rpi-access-point/raspberry-pi-hotspot.sh`

If the access point is down, try running `sudo nmcli connection up Hotspot`

To ensure it starts on every boot, do the following:

`sudo crontab -e`

Add a line that says the following:

`@reboot sudo nmcli connection up Hotspot`

If you make a password entry error, just re-run the script. It will remove your first attempt and let you reset it.

## VPN script
The VPN script will set up a VPN tunnel for all connected devices. Access Point is required before running the following command:

`./rpi-access-point/vpn-setup.sh`

If the VPN is down, try running `sudo openvpn --config "/etc/openvpn/server/vpn-server.conf" --auth-nocache`. This will start it up but take over your terminal session and will exit when you close the window.

I prefer to run this in cronntab as well, by running:

`sudo crontab -e`

Add lines that say the following:

`@reboot sudo openvpn --config "/etc/openvpn/server/vpn-server.conf" --auth-nocache`

`@reboot sudo resolvectl dns eth0 1.1.1.3 1.0.0.3 &&  systemctl restart systemd-resolved.service`

## About
Tested as working on Raspberry Pi 4 running Ubuntu Server Headless 24.04 LTS 64-bit.

These scripts are an enhancement of instructions from PiMyLifeUp articles:

https://pimylifeup.com/raspberry-pi-wireless-access-point/

https://pimylifeup.com/raspberry-pi-vpn-access-point/

Some of the VPN DNS leak instructions may be inert on current operating systems.

I originally came across those articles with the intention of spoofing my location for an approved work remote trip to Bulgaria. Other applications for the bash scripts could be dodging geo-restrictions, getting accurate information from a censored jurisdiction, or just extending a wireless network. While I don't need VPN for any of those applications now, these files will help me keep track of them for the future.

Scripts were written with assistance from ChatGPT and Gemini but don't blame them for the chmod on resolved.conf... that whole operation was my idea. Speaking of, you might want to back that file up before running the VPN setup script. These were written with the assumption that nothing is important on my devices.
