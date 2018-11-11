#!/usr/bin/env bash

echo '[bootstrap] Provisioning virtual machine...'

echo '[bootstrap] Updating...'
sudo /usr/bin/apt-get update >> /vagrant/vm_build.log 2>&1
sudo /usr/bin/apt-get -y upgrade >> /vagrant/vm_build.log 2>&1

# Install puppet
echo '[bootstrap] Installing Puppet...'
sudo /usr/bin/wget https://apt.puppetlabs.com/puppet5-release-xenial.deb >> /vagrant/vm_build.log 2>&1
sudo /usr/bin/dpkg -i puppet5-release-xenial.deb >> /vagrant/vm_build.log 2>&1
sudo /usr/bin/apt-get update >> /vagrant/vm_build.log 2>&1
sudo /usr/bin/apt-get install puppet-agent=5.5.7* >> /vagrant/vm_build.log 2>&1

# Add jenkins-deploy user
echo '[bootstrap] Adding jenkins-deploy user...'
sudo /usr/sbin/adduser jenkins-deploy >> /vagrant/vm_build.log 2>&1

# Add deploy group
echo '[bootstrap] Adding deploy group...'
sudo /usr/sbin/addgroup deploy >> /vagrant/vm_build.log 2>&1

# Install ip-tables
echo '[bootstrap] Installing ip-tables...'
sudo /usr/bin/apt-get install -y netfilter-persistent >> /vagrant/vm_build.log 2>&1

printf "\n"
