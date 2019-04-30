# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "gusztavvargadr/windows-10"
  config.vm.define "windows_10_provision_test"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 3
  end
end
