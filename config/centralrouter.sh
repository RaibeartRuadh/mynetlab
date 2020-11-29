#!/bin/bash
sysctl net.ipv4.conf.all.forwarding=1
echo "net.ipv4.conf.all.forwarding=1" > /etc/sysctl.d/net.conf
echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
echo "GATEWAY=192.168.255.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
ifcfg_eth1=/etc/sysconfig/network-scripts/ifcfg-eth1
route_eth1=/etc/sysconfig/network-scripts/route-eth1
ip_last_octet=(5 9);for i in "${ip_last_octet[@]}"; do \
case "$i" in
"5")
postfix="0"
remote_net="2"
remote_gw="6"
;;
"9")
postfix="1"
remote_net="1"
remote_gw="10"
;;
esac

echo "NM_CONTROLLED=yes" > $ifcfg_eth1:$postfix
echo "BOOTPROTO=none" >> $ifcfg_eth1:$postfix
echo "ONBOOT=yes" >> $ifcfg_eth1:$postfix
echo "IPADDR=192.168.255.$i" >> $ifcfg_eth1:$postfix
echo "NETMASK=255.255.255.252" >> $ifcfg_eth1:$postfix
echo "DEVICE=eth1:$postfix" >> $ifcfg_eth1:$postfix
echo "PEERDNS=no" >> $ifcfg_eth1:$postfix

echo "192.168.$remote_net.0/24 via 192.168.255.$remote_gw dev eth1:$postfix src 192.168.255.$i" >> $route_eth1
done
systemctl restart network
yum install mc net-tools -y

