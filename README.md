# Vagrant for testing LAMP puppet configuration
This is a vagrant installation to test [puppet-lamp](https://github.com/markolly/puppet-lamp) module on Ubuntu 1604. It will create two boxes, one front-end and one database server.

## Virtualbox
This was tested on v5.2.8. Download VirtualBox Platform and VirtualBox Extension Pack from: Install virtualbox: https://www.virtualbox.org/wiki/Downloads

## Vagrant
The vagrant version used was v2.0.2. Vagrant can be downloaded from: https://www.vagrantup.com/downloads.html

## Installation
Clone the repo and install required modules.
```
git clone git@github.com:markolly/vagrant-lamp.git
cd vagrant-lamp
make install
```
An apache test page should now be available at http://localhost:8080

## Make
To "make" life simpler there is a Makefile with some bundled commands. More information about the commands can be found out by running "make help".
```
make help
the help menu
  make install       Install dependencies and start VM(s)
  make start         Equivalent to vagrant up
  make clean         Force destruction of vagrant VM(s)
  make test          Check your vagrant VM(s) are configured correctly
```

## Testing
Once the boxes are running and fully provisioned you can now run some tests. The tests use Serverspec and will test the puppet configuration has been applied correctly.
```
rake spec
```
