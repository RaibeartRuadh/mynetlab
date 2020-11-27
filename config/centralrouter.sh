#!/bin/bash
sysctl net.ipv4.conf.all.forwarding=1
echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "GATEWAY=192.168.255.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
systemctl restart network
ip route add default via 192.168.255.1
ip route add 192.168.2.0/24 via 192.168.0.34
ip route add 192.168.1.0/24 via 192.168.0.35
