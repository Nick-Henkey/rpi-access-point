#!/bin/bash

# Install OpenVPN
echo "Installing OpenVPN..."
sudo apt install openvpn -y

# Create the auth.txt file and prompt for credentials
echo "Creating auth.txt for OpenVPN credentials..."
sudo touch /etc/openvpn/auth.txt
echo "Please enter your OpenVPN service credentials (not your usual VPN account credentials)."
read -p "Username: " username
read -sp "Password: " password
echo
echo -e "$username\n$password" | sudo tee /etc/openvpn/auth.txt > /dev/null
sudo chmod 600 /etc/openvpn/auth.txt

# Navigate to the OpenVPN server directory
cd /etc/openvpn

# Prompt the user for the OpenVPN configuration file link and download it
read -p "Enter the link to your OpenVPN configuration file: " ovpn_link
sudo wget "$ovpn_link"
sudo mv *.ovpn server/vpn-server.conf

# Update the configuration to use the auth.txt file
sudo sed -i 's/auth-user-pass/auth-user-pass \/etc\/openvpn\/auth.txt/g' server/vpn-server.conf

# Flush existing IP tables
echo "Flushing IP tables..."
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -X

# Force wlan0 over tun0
echo "Setting up IP tables for VPN..."
sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE

# Save the new IP tables rules
echo "Saving IP tables rules..."
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

# Set DNS servers for wlan0
sudo resolvectl dns eth0 1.1.1.3 1.0.0.3

# Set DNS servers for resolved system d service after reboot
sudo chmod 666 /etc/systemd/resolved.conf
sudo echo "DNS=1.1.1.1 1.0.0.1" >> /etc/systemd/resolved.conf
sudo chmod 644 /etc/systemd/resolved.conf

echo "DNS settings for eth0:"
resolvectl status eth0

# Enable the OpenVPN server configuration to start on boot
sudo sed -i 's/#AUTOSTART="all"/AUTOSTART="\/etc\/openvpn\/server\/vpn-server.conf"/g' /etc/default/openvpn

# Set static DNS servers
echo "Configuring static DNS servers..."
sudo echo "static domain_name_servers=1.1.1.3 1.0.0.3" | sudo tee -a /etc/dhcpcd.conf

echo "OpenVPN setup complete!"
