---
layout: post
title: "Instalar Docker en Linux Mint 20 y Ubuntu 20.04"
date: 2020-07-01
sources:
- https://docs.docker.com/engine/install/ubuntu/
categories:
- Docker
---

Para instalar Docker en Linux Mint 20 (también aplica a Ubuntu 20.04 Focal Fossa) podemos hacerlo de dos formas:

- Instalar la versión de Docker de los repositorios de Ubuntu
- Instalar la versión del repositorio de Docker

A mi me gusta más la segunda opción porque instala una versión más actual de Docker y se actualiza más a menudo. Para ello seguimos estos pasos:

{% highlight bash %}
$ echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo apt update
$ sudo apt install docker-ce docker-ce-cli containerd.io pigz
{% endhighlight %}

Para poder usar el comando ```docker``` desde cualquier usuario, no olvides añadirlo al grupo **docker**:

{% highlight bash %}
$ sudo usermod -aG docker $USER
{% endhighlight %}

## Docker Compose
Lo mismo pasa con Docker Compose, que también se podría instalar desde los repositorios de Ubuntu, sin embargo también prefiero una versión más actualizada:

{% highlight bash %}
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.26.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
{% endhighlight %}

Y con esto ya lo tendríamos todo.
