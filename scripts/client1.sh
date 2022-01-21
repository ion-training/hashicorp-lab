#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# pre-reqs
apt-get update
apt-get install -y zip unzip bash-completion

# NOMAD #
#########

# hashicorp apt repo
# curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
# apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install consul
apt-get update
apt-get install -y consul
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
chown root:root nomad
mv nomad /usr/bin/
sudo useradd --system --home /etc/nomad.d --shell /bin/false nomad
cp -ap /vagrant/conf/nomad.service /etc/systemd/system/

# create directories
mkdir -p /opt/nomad
mkdir -p /etc/nomad.d

chmod 700 /opt/nomad
chmod 700 /etc/nomad.d

cp -ap /vagrant/conf/client1/nomad.hcl /etc/nomad.d/
chown -R nomad: /etc/nomad.d /opt/nomad/

# nomad set bash env
cp -ap /vagrant/conf/client1/nomad-bash-env.sh /etc/profile.d/

# Enable Nomad service
systemctl enable nomad
systemctl start nomad


# DOCKER #
##########
# install docker
apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# add auto completion for docker
curl -fsSL https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
curl -fsSL https://github.com/docker/docker-ce/blob/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

# facilitate nomad access to docker
usermod -G docker -a nomad

# bash completion for docker
curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

# ENVOY #
#########
curl -fsSL https://func-e.io/install.sh | bash -s -- -b /usr/local/bin
sudo cp `func-e which` /usr/local/bin


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
cp -ap /vagrant/conf/client1/consul.hcl /etc/consul.d/
chown -R consul: /etc/consul.d /opt/consul/

# consul set bash env
cp -ap /vagrant/conf/client1/consul-bash-env.sh /etc/profile.d/

systemctl enable consul
systemctl start consul

# optional liquidprompt #
#########################
apt-get install liquidprompt
liquidprompt_activate
