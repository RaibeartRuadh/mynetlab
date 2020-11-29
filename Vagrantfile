# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
:inetRouter => {
        :box_name => "centos/6",
        :net => [
                   {ip: '192.168.255.1', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router-net"},
                ]
  },
  :centralRouter => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.255.2', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router-net"},
                   {ip: '192.168.0.1', adapter: 3, netmask: "255.255.255.240", virtualbox__intnet: "dir-net"},
                   {ip: '192.168.0.33', adapter: 4, netmask: "255.255.255.240", virtualbox__intnet: "hw-net"},
                   {ip: '192.168.0.65', adapter: 5, netmask: "255.255.255.192", virtualbox__intnet: "mgt-net"},
                ]
  },
  
  :centralServer => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.0.2', adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "dir-net"},
                   {adapter: 3, auto_config: false, virtualbox__intnet: true},
                   {adapter: 4, auto_config: false, virtualbox__intnet: true},
                ]
  },

  :office1Router => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.255.6', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router-net"},
                   {ip: '192.168.2.1', adapter: 3, netmask: "255.255.255.192", virtualbox__intnet: "dev1-net"},
                   {ip: '192.168.2.65', adapter: 4, netmask: "255.255.255.192", virtualbox__intnet: "test1-net"},
                   {ip: '192.168.2.129', adapter: 5, netmask: "255.255.255.192", virtualbox__intnet: "managers1-net"},
                   {ip: '192.168.2.193', adapter: 6, netmask: "255.255.255.192", virtualbox__intnet: "hw1-net"},
                ]
  },

  :office1Server => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.2.66', adapter: 2, netmask: "255.255.255.192", virtualbox__intnet: "test1-net"},
                ]
  },

  :office2Router => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.255.10', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router-net"},
                   {ip: '192.168.1.1', adapter: 3, netmask: "255.255.255.128", virtualbox__intnet: "dev2-net"},
                   {ip: '192.168.1.129', adapter: 4, netmask: "255.255.255.192", virtualbox__intnet: "test2-net"},
                   {ip: '192.168.1.193', adapter: 5, netmask: "255.255.255.192", virtualbox__intnet: "hw2-net"},
                ]
  },

  :office2Server => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.1.130', adapter: 2, netmask: "255.255.255.192", virtualbox__intnet: "test2-net"},
                ]
  },
  
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|
    config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s
        box.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "200"]
        end
        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        if boxconfig.key?(:public)
          box.vm.network "public_network", boxconfig[:public]
        end
        box.vm.provision "shell", path: "config/sshscript.sh"
        case boxname.to_s
        when "inetRouter"
          box.vm.provision "shell", run: "always", path: "config/inetrouter.sh"
        when "centralRouter"
          box.vm.provision "shell", run: "always", path: "config/centralrouter.sh"
        when "centralServer"
          box.vm.provision "shell", run: "always", path: "config/centralserver.sh"
        when "office1Router"
          box.vm.provision "shell", run: "always", path: "config/office1router.sh"
        when "office1Server"
          box.vm.provision "shell", run: "always", path: "config/office1server.sh"
        when "office2Router"
          box.vm.provision "shell", run: "always", path: "config/office2router.sh"
        when "office2Server"
          box.vm.provision "shell", run: "always", path: "config/office2server.sh"
        end
      end
  end  
end
