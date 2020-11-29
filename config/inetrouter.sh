#!/bin/bash
sysctl net.ipv4.conf.all.forwarding=1
echo "net.ipv4.conf.all.forwarding=1" > /etc/sysctl.d/net.conf
iptables -t nat -A POSTROUTING ! -d 192.168.0.0/16 -o eth0 -j MASQUERADE
route_eth1=/etc/sysconfig/network-scripts/route-eth1
touch $route_eth1
net_array=(255.4/30 255.8/30 0.0/24 1.0/24 2.0/24)
for i in "${net_array[@]}"; do \
echo "192.168.$i via 192.168.255.2 dev eth1" >> $route_eth1
done
service network restart
yum install mc net-tools -y
