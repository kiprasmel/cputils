.PHONY: all setup-dev test install

preinstall: setup-dev test

install:
	./install.sh

setup-dev:
	./setup-dev.sh

test:
	./test.sh --all

