# -*- mode: ruby -*-
# vi: set ft=ruby :

# plugin validation
required_plugins = ['vagrant-hostsupdater', 'vagrant-bindfs', 'vagrant-triggers']
required_plugins.each do |plugin|
  unless Vagrant.has_plugin?(plugin)
    raise "#{plugin} is not installed! please run 'vagrant plugin install #{plugin}'"
  end
end

# load config
CONFIG = File.join(File.dirname(__FILE__), "conf/vagrant/config.rb")
if File.exist?(CONFIG)
  require CONFIG
end

Vagrant.configure("2") do |config|
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # vm
  config.vm.provider :virtualbox do |vb|
    vb.name = "#{$project_name}-dev-box"
    vb.cpus = $vm_cpus
    vb.customize ["modifyvm", :id, "--memory", $vm_memory]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # network
  config.vm.network "private_network", ip: $private_ip
  config.vm.hostname = "#{$project_name}.local.dev"
  config.hostsupdater.aliases = $host_names

  # ssh
  config.ssh.forward_agent = true

  # provision
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get -yqq install python
  SHELL

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "conf/ansible/main.yml"
  end

  # synced folder
  config.nfs.map_uid = Process.uid
  config.nfs.map_gid = Process.gid

  if Vagrant::Util::Platform.windows?
    config.vm.synced_folder ".", "/vagrant", create: true
  else
    config.vm.synced_folder ".", "/vagrant", create: true, nfs: true,
      mount_options: ['rw', 'vers=3', 'actimeo=2', 'tcp', 'fsc']
    config.bindfs.bind_folder "/vagrant/#{$source_folder}", $bindfs_folder, 
      :owner => $source_owner, :group => $source_group, :'create-as-user' => true, 
      :perms => "u=rwx:g=rwx:o=rD", :'create-with-perms' => "u=rwD:g=rD:o=rD", 
      :'chown-ignore' => true, :'chgrp-ignore' => true, :'chmod-ignore' => true
  end

  # trigger
  config.trigger.after :up do
    run_remote "/vagrant/conf/vagrant/after_up.sh"
  end

  config.trigger.after :destroy do
    run "/vagrant/conf/vagrant/after_destroy.sh"
  end
end
