# vagrant for development

## install ansible

http://docs.ansible.com/ansible/intro_installation.html#installing-the-control-machine

```
$ brew install ansible
```

## install plugin

```
$ vagrant plugin install vagrant-hostsupdater
$ vagrant plugin install vagrant-bindfs
$ vagrant plugin install vagrant-triggers
```

## custom config

`conf/vagrant/config.rb`

## vagrant up & destroy trigger

```
# after vagrant up
$ conf/vagrant/after_up.sh
# after vagrant destroy
$ conf/vagrant/after_destroy.sh
```
