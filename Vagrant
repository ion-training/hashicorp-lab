# -*- mode: ruby -*-
# vi: set ft=ruby :

# IP ranges

# syslog "192.168.56.51"

# vault "192.168.56.61"

# nomad server "192.168.56.71"
# nomad client "192.168.56.75"

# consul server "192.168.56.81"
# consul client "192.168.56.85"


Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"


  config.vm.define "syslog" do |syslog|
    syslog.vm.hostname = "syslog"
    syslog.vm.provision "shell", path: "scripts/syslog.sh"
    syslog.vm.network "private_network", ip: "192.168.56.51"
  end

  config.vm.define "server" do |server|
    server.vm.hostname = "server"
    server.vm.provision "shell", path: "scripts/server.sh"
    server.vm.network "private_network", ip: "192.168.56.71"
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client"
    client.vm.provision "shell", path: "scripts/client.sh"
    client.vm.network "private_network", ip: "192.168.56.75"

    client.vm.provider "virtualbox" do |v|
      v.memory = 1024*2
      v.cpus = 2
    end

  end

end
