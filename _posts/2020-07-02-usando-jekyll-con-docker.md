---
layout: post
title: "Usando Jekyll con Docker"
date: 2020-07-01
sources:
- https://hub.docker.com/r/jekyll/jekyll/
categories:
- Docker
---

Hasta ahora habia usado Jekyll instalando el paquete desde los repositorios de Ubuntu, pero resulta que por un problema de incompatibilidad no para de dar warnings del tipo:

{% highlight text %}
/usr/lib/ruby/vendor_ruby/jekyll/tags/include.rb:194: warning: Using the last argument as keyword parameters is deprecated
{% endhighlight %}

Y me resulta extremadamente molesto, por lo que estuve buscando alguna opción que evitara dichos mensajes. Parece que en la siguiente versión de Jekyll está corregido, pero desafortunadamente implica compilar y bueno, no me apetecía instalar las dependencias necesarias.

Se me ocurrió que podría existir una imagen de Docker y ... Bingo! Con la imagen de Docker funciona y no escupe esos dichosos warnings. De esta forma iniciamos Jekyll en modo servidor:

{% highlight bash %}
$ docker run -ti --rm -p "4000:4000" -v "$(pwd):/srv/jekyll" jekyll/jekyll:3.8 jekyll serve
{% endhighlight %}

## Mejorando lo mejorable

Cómo podríamos hacerlo incluso más fácil? Con nuestro viejo amigo el Makefile:

{% highlight make %}
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
{% endhighlight %}

De esta forma, para iniciar Jekyll en modo servidor simplemente tenemos que escribir:

{% highlight bash %}
$ make serve
{% endhighlight %}

Genial, verdad?
