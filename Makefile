.PHONY: all setup-dev test install

all: setup-dev test install

install:
	./install.sh

setup-dev:
	./setup-dev.sh

test:
	./test.sh --all

