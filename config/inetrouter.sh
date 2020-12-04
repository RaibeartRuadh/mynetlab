#!/bin/bash
sysctl net.ipv4.conf.all.forwarding=1
echo "net.ipv4.conf.all.forwarding=1" > /etc/sysctl.d/net.conf
iptables -t nat -A POSTROUTING ! -d 192.168.0.0/16 -o eth0 -j MASQUERADE
ip route add 192.168.0.0/16 via 192.168.255.2
service network restart
yum install mc net-tools -y
