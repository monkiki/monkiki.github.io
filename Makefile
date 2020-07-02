GREEN := \033[1;32m
BLUE := \033[1;34m
RESET := \033[0m

# The directory of this file
DIR := $(shell echo $(shell cd "$(shell dirname "${BASH_SOURCE[0]}" )" && pwd ))

IMAGE_NAME ?= jekyll/jekyll
IMAGE_VERSION ?= 3.8

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "${GREEN}%-30s${RESET} %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

serve: ## Local server
	@echo "${BLUE}Server $(IMAGE_NAME):$(IMAGE_VERSION)${RESET}"
	docker run -ti --rm -p "4000:4000" -v "$(DIR):/srv/jekyll" $(IMAGE_NAME):$(IMAGE_VERSION) jekyll serve

build: ## Build site
	@echo "${BLUE}Build $(IMAGE_NAME):$(IMAGE_VERSION)${RESET}"
	docker run -ti --rm -v "$(DIR):/srv/jekyll" $(IMAGE_NAME):$(IMAGE_VERSION) jekyll build

