#!/bin/bash

echo "Updating system before running ansible..."
echo ""

sudo apt update && sudo apt upgrade -y

echo "Installing ansible..."
echo ""
sudo apt install ansible

echo "Running install playbook..."
echo ""

#sudo ansible-playbook update_and_install_packages.yml
