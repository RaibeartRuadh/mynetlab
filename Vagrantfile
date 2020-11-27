# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
########## SERVERS ###############################
  :InetRouter => {
        :box_name => "centos/7",
        :net => [{virtualbox__intnet: "inetrouter", ip: '192.168.255.1', netmask: "255.255.255.252"},]},
  :CentralServer => {
        :box_name => "centos/7",
        :net => [{virtualbox__intnet: "central", ip: '192.168.0.2', netmask: "255.255.255.240"},]},
  :Office1Server => {
        :box_name => "centos/7",
        :net => [{virtualbox__intnet: "office1", ip: '192.168.2.2',  netmask: "255.255.255.192"},]},
  :Office2Server => {
        :box_name => "centos/7",
        :net => [{virtualbox__intnet: "office2", ip: '192.168.1.2', netmask: "255.255.255.128"},]},

########## ROUTERS ###############################
  :CentralRouter => {
        :box_name => "centos/7",
        :net => [
			{virtualbox__intnet: "central", ip: '192.168.0.1', netmask: "255.255.255.240"},
			{virtualbox__intnet: "inetrouter", ip: '192.168.255.2', netmask: "255.255.255.252"},
			{virtualbox__intnet: "hw-net", ip: '192.168.0.33',  netmask: "255.255.255.240"},
			{virtualbox__intnet: "mgt-net", ip: '192.168.0.65',  netmask: "255.255.255.192"},
		]},
  :Office1Router => {
        :box_name => "centos/7",
        :net => [
			{virtualbox__intnet: "hw-net", ip: '192.168.0.34', netmask: "255.255.255.240"},
			{virtualbox__intnet: "office1", ip: '192.168.2.1',  netmask: "255.255.255.192"},
		]},
  :Office2Router => {
        :box_name => "centos/7",
        :net => [
			{virtualbox__intnet: "hw-net", ip: '192.168.0.35', netmask: "255.255.255.240"},
			{virtualbox__intnet: "office2", ip: '192.168.1.1', netmask: "255.255.255.128"},
		]},
	}
##################################################

Vagrant.configure("2") do |config|
    MACHINES.each do |boxname, boxconfig|
        config.vm.define boxname do |box|
            box.vm.box = boxconfig[:box_name]
            box.vm.host_name = boxname.to_s
            boxconfig[:net].each do |ipconf|
                box.vm.network "private_network", ipconf

         	    end
            if boxconfig.key?(:public)
                box.vm.network "public_network", boxconfig[:public]
                                   auto_config[:false]
        	 end
            case boxname.to_s
            when "InetRouter"
                box.vm.provision "shell", run: "always", path: "config/inetrouter.sh" 
            when "CentralRouter"
                box.vm.provision "shell", run: "always", path: "config/centralrouter.sh" 
            when "CentralServer"
                box.vm.provision "shell", run: "always", path: "config/centralserver.sh"
            when "Office1Router"
                box.vm.provision "shell", run: "always", path: "config/office1router.sh"
            when "Office1Server"
                box.vm.provision "shell", run: "always", path: "config/office1server.sh"
            when "Office2Router"
                box.vm.provision "shell", run: "always", path: "config/office2router.sh"
            when "Office2Server"
                box.vm.provision "shell", run: "always", path: "config/office2server.sh"
            end
        end
    end
end

