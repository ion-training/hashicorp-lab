#!/usr/bin/env bash
echo ${HOSTNAME}

export DEBIAN_FRONTEND=noninteractive

# pre-reqs
apt-get update
apt-get install -y zip unzip

# ENVOY #
#########
curl -fsSL https://func-e.io/install.sh | bash -s -- -b /usr/local/bin
sudo cp `func-e which` /usr/local/bin


# hashicorp apt repo
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install consul
apt-get update
apt-get install consul

# install consul manually
# export CONSUL_VERSION="1.10.3"
# export CONSUL_URL="https://releases.hashicorp.com/consul"
# export ARCH=$(lsb_release -cs)
# curl -fsSL https://releases.hashicorp.com/consul/1.10.3/consul_1.10.3_darwin_amd64.zip -o consul.zip
# unzip consul.zip
# useradd --system --home /etc/consul.d --shell /bin/false consul
# chown root:root consul
# mv consul /usr/bin/

# copy service config
# cp -ap /vagrant/conf/consul.service /etc/systemd/system/consul.service

# create directories
mkdir --parents /etc/consul.d/
mkdir --parents /opt/consul/
chown --recursive consul:consul /etc/consul.d

# copy consul config
cp -ap /vagrant/conf/consul1/consul.hcl /etc/consul.d/
chown -R consul:consul /etc/consul.d /opt/consul/
chmod 640 /etc/consul.d/consul.hcl

# consul set bash env
cp -ap /vagrant/conf/consul1/consul-bash-env.sh /etc/profile.d/


systemctl enable consul
systemctl start consul
