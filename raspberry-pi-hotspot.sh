#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install network-manager if it's not already installed
echo "Installing Network Manager..."
sudo apt install -y network-manager

# Check if a Hotspot connection exists
if nmcli connection show | grep -q "Hotspot"; then
    echo "Hotspot connection found. Deleting it..."
    sudo nmcli connection delete Hotspot
    echo "Hotspot deleted successfully."
else
    echo "No Hotspot connection found."
fi

# Prompt the user for network Password
read -sp "Enter the network Password: " password
echo

# Set up the Wi-Fi hotspot
echo "Setting up the Wi-Fi hotspot with SSID Pi-Gateway"
sudo nmcli d wifi hotspot ifname wlan0 ssid Pi-Gateway password "$password"

echo "Wi-Fi hotspot setup complete."
