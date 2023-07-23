DEPLOY_DIR=public
DEPLOY_FILE=public.zip

SHELL := /bin/bash

# Setup dev environment
install:
	npm i
	git submodule update --init
	mkdir -p data
	./scripts/motd.sh "I mount my soul at /dev/null" > data/cow
	cd ./themes/arsmateria-zola-theme && ./script/postinstall.sh

build:
	zola build

run:
	zola serve

$(DEPLOY_FILE):
	zip -r $(DEPLOY_FILE) $(DEPLOY_DIR)

deploy: build $(DEPLOY_FILE)
	./script/export_netlify.sh $(DEPLOY_FILE)

clean:
	rm -rf $(DEPLOY_FILE) $(DEPLOY_DIR)