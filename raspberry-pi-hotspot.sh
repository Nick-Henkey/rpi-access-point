#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install network-manager if it's not already installed
echo "Installing Network Manager..."
sudo apt install -y network-manager

# Check if wpa_supplicant.conf file exists
if [ ! -f /etc/wpa_supplicant/wpa_supplicant.conf ]; then
  echo "wpa_supplicant.conf file not found. Creating..."
  # Create an empty file using 'touch'
  sudo touch /etc/wpa_supplicant/wpa_supplicant.conf 
fi

# Optional: Set file permissions (if needed)
sudo chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf 

echo "wpa_supplicant.conf file created or already exists."

# Prompt the user for network Password
read -sp "Enter the network Password: " password
echo

# Set up the Wi-Fi hotspot
echo "Setting up the Wi-Fi hotspot with SSID Pi-Gateway"
sudo nmcli d wifi hotspot ifname wlan0 ssid Pi-Gateway password "$password"

echo "Wi-Fi hotspot setup complete."
