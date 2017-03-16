---
author: monkiki
comments: true
date: 2015-12-30 08:47:18+00:00
layout: post
link: https://monkiki.wordpress.com/2015/12/30/instalar-la-ultima-version-de-arduino-ide-en-ubuntu-linux-mint/
slug: instalar-la-ultima-version-de-arduino-ide-en-ubuntu-linux-mint
title: Instalar la última versión de Arduino IDE en Ubuntu / Linux Mint
wordpress_id: 241
categories:
- Arduino
- Ubuntu
---

La versión del Arduino IDE que viene en los repositorios de Ubuntu / Linux Mint es muy antigua: es la 1.0.5 y en estos momentos la última versión disponible para descargar es la 1.6.7. Como no he encontrado ningún PPA con la última versión, comento los pasos a seguir para poder instalar la versión que se descarga.
	
  * Descarga el archivo de [https://www.arduino.cc/en/Main/Software](https://www.arduino.cc/en/Main/Software)

  * Descomprimir el archivo:

{% highlight bash %}
$ tar -xvf arduino-1.6.7-linux64.tar.xz
{% endhighlight %}

  * Mover el directorio a /opt:

{% highlight bash %}
$ sudo mv arduino-1.6.7 /opt
{% endhighlight %}

  * Ejecutar el instalador:

{% highlight bash %}
$ /opt/arduino-1.6.7/install.sh
{% endhighlight %}
	
  * Añadir nuestro usuario al grupo "dialout":

{% highlight bash %}
$ useradd -G dialout username
{% endhighlight %}

Este último paso es importante para poder programar nuestro Arduino ya que si no, dará un error de que no tiene permisos de escrituras en el pue
