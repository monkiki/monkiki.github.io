---
author: monkiki
comments: true
date: 2009-09-02 06:57:47+00:00
layout: post
link: https://monkiki.wordpress.com/2009/09/02/compartir-ficheros-de-forma-rapida/
slug: compartir-ficheros-de-forma-rapida
title: Compartir ficheros de forma rápida
wordpress_id: 10
categories:
- Ubuntu
tags:
- python
---

A veces necesitas compartir unos ficheros con un compañero de trabajo u otra persona. De hecho puede que sea algo puntual y lo necesitas ya! No te vas a poner a instalar y configurar algún paquete porque tienes prisa. Bien, existe una forma muy simple de hacerlo y con sólo una línea. Sólo depende de que tengas Python instalado en tu máquina, y si usas Ubuntu seguro que cumples con este requisito.

La línea mágica es la siguiente:

{% highlight bash %}
$ python -c "import SimpleHTTPServer; SimpleHTTPServer.test();"
{% endhighlight %}

Para comprobar que funciona ve a [http://localhost:8000](http://localhost:8000). Lo bueno que tiene este sistema es que incluso puedes compartir con personas que estén en la otra punta del mundo. El único trabajo adicional será configurar el NAT de tu router para que apunte al puerto 8000 de tu máquina.

Simplemente di a la otra persona que vaya a [http://tu-ip:8000](http://tu-ip:8000) desde su navegador y verá la lista de ficheros y directorios que compartes. Cuando quieras dejar de compartir esos ficheros, simplemente haz un CTRL+C .

Aún lo puedes hacer más fácil insertando este alias en tu fichero ~/.bashrc :

{% highlight bash %}
alias webshare='python -c "import SimpleHTTPServer; SimpleHTTPServer.test();"'
{% endhighlight %}
