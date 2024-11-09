export MAKE := make

archive-dist:
	@echo "- dist: creating docker webscraper packages"
	@tar czf dist/docker_webscraper.tar.gz -C docker $(shell ls docker)

rebuild-base-image:
	$(MAKE) -C vagrant/base_image rebuild-base-image

start-vm:
	$(MAKE) -C vagrant/webscraper start-vm

teardown-vm:
	$(MAKE) -C vagrant/webscraper teardown-vm

build-env-image:
	$(MAKE) -C docker build-image

env-up:
	$(MAKE) -C docker env-up

env-down:
	$(MAKE) -C docker env-down

remove-env-image:
	$(MAKE) -C docker remove-image
