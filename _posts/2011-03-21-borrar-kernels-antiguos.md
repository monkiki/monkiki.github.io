---
author: monkiki
comments: true
date: 2011-03-21 08:59:23+00:00
layout: post
link: https://monkiki.wordpress.com/2011/03/21/borrar-kernels-antiguos/
slug: borrar-kernels-antiguos
title: Borrar kernels antiguos
wordpress_id: 190
categories:
- Debian
- Ubuntu
---

Cada vez que nuestro sistema Linux instala una actualización del kernel (o instalamos nosotros uno compilado por nosotros mismos), la versión anterior no es eliminada. Con el paso del tiempo, se acumulan varias versiones del kernel en el mismo sistema. Esto puede suponer un problema si hemos asignado poco espacio a la partición **/boot**.

En GRUB aparece una linea por cada kernel instalado, aunque sean versiones viejas. Por una parte esto es una ventaja, ya que da la opción de arrancar con un kernel anterior, por si el nuevo nos da problemas. Muy importante cuando compilamos un kernel optimizado por nosotros, o probamos alguna versión o módulo experimental.

Pero una vez testeado, no tiene mucho sentido mantener los kernel anteriores. Veremos una forma sencilla de borrar los kernels que ya no utilizamos en nuestro sistema Debian/Ubuntu, y liberar ese espacio del disco duro.

Para ver las versiones del kernel que hay en tu sistema usaremos este comando:

{% highlight bash %}
$ dpkg -l | grep linux-image
{% endhighlight %}

Ahora sólo tenemos que ir borrando el kernel junto con sus headers. Por ejemplo, en el caso en el que quisiéramos borrar un kernel 2.6.34 haríamos:

{% highlight bash %}
$ aptitude purge linux-image-2.6.34 linux-headers-2.6.34
{% endhighlight %}

Recuerda, **es muy importante no borrar el kernel actual**. Tampoco borres el paquete **linux-image-generic** presente en las distribuciones Ubuntu.

Y por último, para ver qué versión de kernel estamos usando ejecuta:

{% highlight bash %}
$ uname -r
{% endhighlight %}

No rompáis nada :)
