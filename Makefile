SHELL := /bin/bash

start:
	if [ -e nginx.conf ]; then mv nginx.conf nginx.conf.bak; fi;
	python3 scripts/generate_nginx_conf.py
	docker-compose up --build --detach

stop:
	docker-compose stop

