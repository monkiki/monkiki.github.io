---
author: monkiki
comments: true
date: 2011-03-09 12:03:09+00:00
layout: post
link: https://monkiki.wordpress.com/2011/03/09/instalar-hot-copy-for-linux-en-ubuntu/
slug: instalar-hot-copy-for-linux-en-ubuntu
title: Instalar Hot Copy for Linux en Ubuntu
wordpress_id: 186
tags:
- Ubuntu
---

Una vez [instalado](http://wiki.r1soft.com/display/LTR1D/Installing+Hot+Copy) el paquete en formato APT perfectamente compilado para tu arquitectura, tienes que instalar el módulo precompilado para tu kernel y compilarlo tu mismo. Para la última versión estable de Ubuntu (_10.10 - Maverick Meerkat_) no hay módulo precompilado, por lo cual hay que hacerlo. Es muy sencillo, ya que existe la utilidad **hcp-setup** que nos ayuda en esta labor... pero no todo es tan perfecto. Cuando intentas compilar el módulo para el **kernel 2.6.35-27-generic** da un feo error:

{% highlight bash %}
yomismo@kraken:~$ sudo hcp-setup --get-module
Checking for binary module
Waiting                       |
No binary module found
Gathering kernel information
Gathering kernel information complete.
Creating kernel headers package
Checking '/tmp/r1soft-cki.1299670593' for kernel headers
Unable to find a 'include/linux/autoconf.h'. This file is required to build a kernel module
Unable to find a valid source directory.
Please install the kernel headers for your operating system.
To install kernel headers execute:
apt-get install linux-headers-`uname -r`
{% endhighlight %}

Dice que no encuentra las cabeceras necesarias para compilarlo e incluso te dice el comando
que has de ejecutar para instalarlas, pero resulta que ya las tengo instaladas. O sea, que algo
raro pasa. El problema es que en el kernel 2.6.35 el fichero autoconf.h está en otro lado:

{% highlight bash %}
$ ls /usr/src/linux-headers-`uname -r`/include/generated/
{% endhighlight %}

En lugar de este otro:

{% highlight bash %}
$ ls /usr/src/linux-headers-`uname -r`/include/linux/
{% endhighlight %}

Y es ahí donde falla la rutina que comprueba que los fuentes del kernel estén instalados. A la hora de compilar no afecta donde esté este fichero ya que encuentra la ruta correcta. Sólo es problema del chequéo que hace el instalador. Por tanto la solución es bien sencilla (y podríamos decir cutre):

{% highlight bash %}
$ sudo touch /usr/src/linux-headers-`uname -r`/include/linux/autoconf.h
{% endhighlight %}

Y listos, hemos creado el fichero autoconf.h donde lo necesita y todo irá como la seda. Lo curioso del invento es que parece que envía los fuentes del kernel a un servidor remoto donde se genera el módulo y luego se lo baja. Supongo que el si otro usuario intenta hacer lo mismo con la misma versión del kernel se limitará a bajar el módulo ya compilado.

**Nota**: *No he conseguido hacer un snapshot, al menos de una partición formateada con ext4 y viendo el log del kernel hay un mensaje aclaratorio:*

{% highlight txt %}
hcp: ERROR: aborting snapshot, your kernel is broken please downgrade or upgrade, snapshots on block devices with ext4 will cause a dead lock.
{% endhighlight %}

*con lo cual habrá que esperar a una actualización del kernel. Supongo que debe estar relacionado con este bug: [lvm snapshot causes deadlock in 2.6.35](https://bugs.launchpad.net/ubuntu/maverick/+source/linux/+bug/595489).*
