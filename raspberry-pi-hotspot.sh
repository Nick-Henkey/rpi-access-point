#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install network-manager if it's not already installed
echo "Installing Network Manager..."
sudo apt install -y network-manager

# Prompt the user for network Password
read -sp "Enter the network Password: " password
echo

# Set up the Wi-Fi hotspot
echo "Setting up the Wi-Fi hotspot with SSID Pi-Gateway"
sudo nmcli d wifi hotspot ifname wlan0 ssid Pi-Gateway password "$password"

echo "Wi-Fi hotspot setup complete."
