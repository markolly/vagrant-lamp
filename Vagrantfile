# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrant LAMP

# Version
Vagrant.require_version ">= 1.8.1"

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

nodes = [
  { :hostname => 'lamp-app-vagrant', :ip => '192.168.0.42', :box => 'markolly/ubuntu1804', :ram => 2048 },
  { :hostname => 'lamp-db-vagrant',  :ip => '192.168.0.43', :box => 'markolly/ubuntu1804', :ram => 2048 }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]

      if node[:hostname] == 'lamp-app-vagrant'
          nodeconfig.vm.network "forwarded_port", guest: 80, host: 8080
      end

      memory = node[:ram] ? node[:ram] : 1024;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          #{}"--cpuexecutioncap", "100",
          "--memory", memory.to_s,
          "--uartmode1", "disconnected"
        ]
        if node[:hostname] == 'lamp-app-vagrant'
            vb.name = "lamp-app-vagrant"
        end
        if node[:hostname] == 'lamp-db-vagrant'
            vb.name = "lamp-db-vagrant"
        end
      end

      if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false
      end
      # Hack to make centos 7 box work with vagrant
      config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

      config.vm.provision :shell, path: "provision/setup-ubuntu.sh"

      # Install basic config
      config.vm.provision "shell",
        inline: "mkdir -p /vagrant/puppet/modules/"
      config.vm.provision "shell",
        inline: "ln -sf /vagrant/files/modules/baseconfig /vagrant/puppet/modules/baseconfig"
      config.vm.provision "shell",
        inline: "mkdir -p /var/www/lamp/"
      config.vm.provision "shell",
        inline: "ln -sf /vagrant/files/www /var/www/lamp"

      config.vm.provision :puppet do |puppet|
        puppet.hiera_config_path = "hiera.yaml"
        puppet.manifests_path = "puppet/manifests"
        puppet.manifest_file = "default.pp"
        puppet.module_path = "puppet/modules"
      end

      if node[:hostname] == 'lamp-app-vagrant'
        # Disable default apache site
        nodeconfig.vm.provision "shell", inline: "echo '[bootstrap] Disable default apache site...'"
        nodeconfig.vm.provision "shell", inline: "a2dissite 000-default >> /vagrant/vm_build.log 2>&1"
        nodeconfig.vm.provision "shell", inline: "service apache2 reload >> /vagrant/vm_build.log 2>&1"
      end

      if node[:hostname] == 'lamp-db-vagrant'
        nodeconfig.vm.provision "shell", inline: "systemctl restart mysql >> /vagrant/vm_build.log 2>&1"
      end

    end
  end

end
