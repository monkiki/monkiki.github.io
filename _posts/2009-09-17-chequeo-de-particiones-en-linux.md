---
author: monkiki
comments: true
date: 2009-09-17 09:45:58+00:00
layout: post
link: https://monkiki.wordpress.com/2009/09/17/chequeo-de-particiones-en-linux/
slug: chequeo-de-particiones-en-linux
title: Chequeo de particiones en linux
wordpress_id: 30
categories:
- Ubuntu
---

Supongamos que hemos tenido algún problema con el disco y queremos comprobar una partición. Lo normal es que la partición esté formateada en ext3, por lo que ejecutamos el comando:

{% highlight bash %}
$ fsck.ext3 /dev/sda1
{% endhighlight %}

Pero puede ser que dicha partición sea la que esté montada como raíz del sistema de ficheros, y no es buena idea usar el comando "fsck" con una partición montada. Una solución forzar el chequeo de la partición en el próximo arranque:

{% highlight bash %}
$ tune2fs -c 3 -C 3 /dev/sda1
{% endhighlight %}

Con esto hacemos que la cuenta de montaje máxima se establezca a 3, y la cuenta actual también a 3 con lo que conseguimos que en el próximo reinicio del sistema se compruebe la partición. También podemos forzar a que se compruebe la partición cada 5 días:

{% highlight bash %}
$ tune2fs -i 5d /dev/sda1
{% endhighlight %}
