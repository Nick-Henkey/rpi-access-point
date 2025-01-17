#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install network-manager if it's not already installed
echo "Installing Network Manager..."
sudo apt install -y network-manager

# Prompt the user for SSID and Password
read -p "Enter the Access Point Name (SSID): " ssid
read -sp "Enter the Password: " password
echo

# Set up the Wi-Fi hotspot
echo "Setting up the Wi-Fi hotspot with SSID '$ssid'..."
sudo nmcli d wifi hotspot ifname wlan0 ssid "$ssid" password "$password"

echo "Wi-Fi hotspot setup complete."
