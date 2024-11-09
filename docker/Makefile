ROOT_DIR := $(shell pwd)

export ROOT_DIR

build-image:
	docker compose build

env-up:
	docker compose up -d

env-stop:
	docker compose stop

env-down:
	docker compose down -v

remove-image: env-down
	docker compose down --rmi all
