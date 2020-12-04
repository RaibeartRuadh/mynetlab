#!/bin/bash
echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
ip route del default

systemctl restart network
echo "GATEWAY=192.168.0.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
systemctl restart network

yum install mc net-tools -y

ping -c 5 -s 10 -W 10 192.168.255.2
ping -c 5 -s 10 -W 10 192.168.255.1
