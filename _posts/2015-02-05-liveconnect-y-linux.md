---
author: monkiki
comments: true
date: 2015-02-05 09:18:32+00:00
layout: post
link: https://monkiki.wordpress.com/2015/02/05/liveconnect-y-linux/
slug: liveconnect-y-linux
title: LiveConnect y Linux
wordpress_id: 221
categories:
- Debian
- Java
- Ubuntu
tags:
- Javascript
- JDK
- linux
- liveconnect
- Oracle
---

Resulta que el problema del LiveConnect ocurre sólo en Linux. Consiste en que no se puede hacer una llamada desde Javascript a un método del Applet. Afecta, por ejemplo, al LiveEdit de OpenKM. Para que funcione desde Linux, o instalas el OpenJDK y el plugin para el navegador IcedTea o tienes que usar el JDK de Oracle 1.7u67. A partir de esa versión ya no funciona.

Instrucciones de instalación:

  * Descargar [jdk-7u67-linux-x64.tar.gz](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html#jdk-7u67-oth-JPR) .

  * Desinstalar JDK previos:

{% highlight bash %}
$ sudo apt-get purge openjdk* icedtea* oracle-java*
{% endhighlight %}

  * Crear directorio de instalación:

{% highlight bash %}
$ sudo mkdir /usr/local/java
{% endhighlight %}

  * Descomprimir el JDK:

{% highlight bash %}
$ sudo tar xzvf Descargas/jdk-7u67-linux-x64.tar.gz -C /usr/local/java/
{% endhighlight %}

  * Poner los comandos del JDK en el PATH; añade al final del fichero **/etc/profile** esto:

{% highlight bash %}
export PATH=$PATH:/usr/local/java/jdk1.7.0_67/bin
{% endhighlight %}

  * Instalar plugin en Firefox (y Chrome):

{% highlight bash %}
$ cd /usr/lib/mozilla/plugins
$ sudo ln -s /usr/local/java/jdk1.7.0_67/jre/lib/amd64/libnpjp2.so .
{% endhighlight %}

A partir de ahora funcionará sin problemas. A la espera de una solución definitiva por parte de Oracle.
