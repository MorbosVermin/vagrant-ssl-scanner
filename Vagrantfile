# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "home/gentoo-i686"
  config.vm.hostname = "ssl-scanner"

  config.vm.provider "virtualbox" do |vb|
  	vb.gui = false
  	vb.name = "SSL SCANNER"
  	vb.memory = "1024"
  end
  
  config.vm.provision "shell", path: "provision.sh", privileged: false
end
