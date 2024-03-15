#!/bin/bash
sudo apt update && sudo apt upgrade -y

sudo apt install python3
sudo apt install python3-pip
sudo pip install flask
sudo apt install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

cd ~
mkdir python
cd python
nano app80.py
#code de flask pour le port 80
nano app5001.py
#code de flask pour le port 5001
sudo python3 app80.py

sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p tcp –dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp –dport 443 -j ACCEPT
sudo iptables -A INPUT -p tcp –dport 22 -j ACCEPT
sudo iptables -I INPUT -p tcp –syn –dport 80 -m connlimit –connlimit-above 10 –connlimit-mask 32 -j REJECT –reject-with tcp-reset

sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A OUTPUT -d 51.12.246.68 -j ACCEPT

sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP

sudo iptables-save > backup_iptables.txt
