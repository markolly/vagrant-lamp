all: help

install:
	@echo "Installing dependencies..."
	@bundle
	@vagrant plugin install vagrant-vbguest
	@librarian-puppet install --path puppet/modules
	@echo "Starting VM(s)..."
	@vagrant up
	@cat provision/read_me.txt

start:
	@echo "Start VM(s)..."
	@vagrant up

clean:
	@echo "Destroying VM(s)..."
	@vagrant destroy -f

test:
	@echo "Running Serverspec tests..."
	@rake spec

help:
	@echo "the help menu"
	@echo "  make install       Install dependencies and start VM(s)"
	@echo "  make start         Equivalent to vagrant up"
	@echo "  make clean         Force destruction of vagrant VM(s)"
	@echo "  make test          Check your vagrant VM(s) are configured correctly"

.PHONY: install start clean test
