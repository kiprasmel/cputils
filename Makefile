.PHONY: setup-dev test install all

install:
	./install.sh

setup-dev:
	./setup-dev.sh

test:
	./test.sh

all: setup-dev test install

