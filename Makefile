SHELL:=/bin/bash

build:
	docker build . -t anatolych/debian-pypy:5.6 --force-rm --compress
