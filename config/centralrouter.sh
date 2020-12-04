#!/bin/bash
echo "net.ipv4.conf.all.forwarding=1" >> /etc/sysctl.d/01-forwarding.conf

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.d/01-forwarding.conf
sysctl -p /etc/sysctl.d/01-forwarding.conf

echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
ip route del default
systemctl restart network

echo "GATEWAY=192.168.255.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
systemctl restart network

ip route add 192.168.1.0/24 via 192.168.255.10
ip route add 192.168.2.0/24 via 192.168.255.6



systemctl restart network
yum install mc net-tools -y





















