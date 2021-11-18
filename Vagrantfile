# -*- mode: ruby -*-
# vi: set ft=ruby :

# IP ranges

# syslog "192.168.56.51"

# vault "192.168.56.61"

# nomad server "192.168.56.71"
# nomad client "192.168.56.75"

# consul server "192.168.56.81"
# consul client "192.168.56.85"

# nomad/consul client1 "192.168.56.91"

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.define "consul1" do |consul1|
    consul1.vm.hostname = "consul1"
    consul1.vm.provision "shell", path: "scripts/consul1.sh"
    consul1.vm.network "private_network", ip: "192.168.56.81"
  end

  config.vm.define "nomad1" do |nomad1|
    nomad1.vm.hostname = "nomad1"
    nomad1.vm.provision "shell", path: "scripts/nomad1.sh"
    nomad1.vm.network "private_network", ip: "192.168.56.71"
  end

  config.vm.define "client1" do |client1|
    client1.vm.hostname = "client1"
    client1.vm.provision "shell", path: "scripts/client1.sh"
    client1.vm.network "private_network", ip: "192.168.56.91"
  end

  config.vm.define "client2" do |client2|
    client2.vm.hostname = "client2"
    client2.vm.provision "shell", path: "scripts/client2.sh"
    client2.vm.network "private_network", ip: "192.168.56.92"
  end

end
