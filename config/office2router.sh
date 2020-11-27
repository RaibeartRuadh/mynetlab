#!/bin/bash
sysctl net.ipv4.conf.all.forwarding=1
echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "GATEWAY=192.168.0.35" >> /etc/sysconfig/network-scripts/ifcfg-eth1
systemctl restart network
ip route delete default 2>&1 >/dev/null || true
ip route add default via 192.168.0.33
ip route add 192.168.2.0/24 via 192.168.0.34
ip addr add 192.168.1.129/26 dev eth2
ip addr add 192.168.1.193/26 dev eth2
