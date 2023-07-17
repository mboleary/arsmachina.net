DEPLOY_DIR=public
DEPLOY_FILE=public.zip

SHELL := /bin/bash

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