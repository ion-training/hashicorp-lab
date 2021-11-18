#!/usr/bin/env bash
echo ${HOSTNAME}

export DEBIAN_FRONTEND=noninteractive

# pre-reqs
apt-get update
apt-get install -y zip unzip

# hashicorp apt repo
# curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
# apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install nomad
# apt-get update
# apt-get install -y nomad
# hash -r
# nomad --autocomplete-install


# install nomad manually
export NOMAD_VERSION="1.1.6"
export ARCH="amd64"
curl -fsSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_${ARCH}.zip -o nomad.zip
unzip nomad.zip
sudo useradd --system --home /etc/nomad.d --shell /bin/false nomad
chown root:root nomad
mv nomad /usr/bin/



# create directories
mkdir -p /opt/nomad
mkdir -p /etc/nomad.d

chmod 700 /opt/nomad
chmod 700 /etc/nomad.d

cp -ap /vagrant/conf/nomad1/nomad.hcl /etc/nomad.d/
chown -R nomad: /etc/nomad.d /opt/nomad/

cp -ap /vagrant/conf/nomad.service /etc/systemd/system/

# nomad set bash env
cp -ap /vagrant/conf/nomad1/nomad-bash-env.sh /etc/profile.d/

systemctl enable nomad
systemctl start nomad


# CONSUL #
##########
# hashicorp apt repo
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install consul
apt-get update
apt-get install -y consul

# create directories
mkdir --parents /etc/consul.d
chown --recursive consul:consul /etc/consul.d
chmod 640 /etc/consul.d/consul.hcl

# copy service config
cp -ap /vagrant/conf/consul.service /usr/lib/systemd/system/consul.service

# copy consul config
cp -ap /vagrant/conf/nomad1/consul.hcl /etc/consul.d/
chown -R consul: /etc/consul.d /opt/consul/

# consul set bash env
cp -ap /vagrant/conf/nomad1/consul-bash-env.sh /etc/profile.d/

systemctl enable consul
systemctl start consul
