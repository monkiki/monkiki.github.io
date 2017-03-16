---
author: monkiki
comments: true
date: 2010-04-19 15:45:14+00:00
layout: post
link: https://monkiki.wordpress.com/2010/04/19/compilar-pdf2swf-con-soporte-para-pdf-protegidos/
slug: compilar-pdf2swf-con-soporte-para-pdf-protegidos
title: Compilar pdf2swf con soporte para PDF protegidos
wordpress_id: 149
categories:
- Ubuntu
---

Existe una herramienta maravillosa que hace la magia de convertir un PDF a SWF (Flash, para que nos entendamos). Si has usado la herramienta habrás comprobado que no funciona con documentos PDF protegidos dando este error:

{% highlight error %}
FATAL   PDF disallows copying
{% endhighlight %}

Pero gracias a que tenemos acceso al [código fuente de la aplicación](http://www.swftools.org/swftools-0.9.0.tar.gz), podemos lo modificar para que se salta dicha comprobación. En concreto tenemos que editar el fichero lib/pdf/pdf.cc y comentar las líneas 136 y 137:

{% highlight c %}
if(!pi->config_print && pi->nocopy) {msg("<fatal> PDF disallows copying");exit(0);}
if(pi->config_print && pi->noprint) {msg("<fatal> PDF disallows printing");exit(0);}}
{% endhighlight %}

La versión de GCC que viene por defecto en Lucid Lynx (GCC-4.4) no se lleva bien con el código fuente de SWFTools 0.9.0 por lo que tenemos que instalar una versión anterior:

{% highlight bash %}
$ sudo apt-get install build-essential gcc-4.3 g++-4.3
{% endhighlight %}

Adicionalmente hay que instalar unas librerías de desarrollo:

{% highlight bash %}
$ sudo apt-get install libungif4-dev libjpeg62-dev libfreetype6-dev
{% endhighlight %}

Y ya que estamos lo compilamos estático para que corra sin problemas en cualquier otro Linux.

{% highlight bash %}
$ CC=/usr/bin/gcc-4.3 CXX=/usr/bin/g++-4.3 LDFLAGS="-static" ./configure
{% endhighlight %}

Si quieres compilar para Windows, puedes hacerlo desde Linux usando MingW:

{% highlight bash %}
$ sudo apt-get install mingw32
{% endhighlight %}

Y luego compilar de esta forma:

{% highlight bash %}
$ ./configure --host=i686-pc-mingw32
{% endhighlight %}

Dará un error pq faltan librerías, como por ejemplo zlib. Para instalar estas librerías compiladas para Windows visita [http://mxe.cc/](http://mxe.cc/).

Más información en:  [http://www.foolabs.com/xpdf/cracking.html](http://www.foolabs.com/xpdf/cracking.html)

**Actualización**: En la versión 0.9.1 hay que modificar el fichero src/jpeg.c cambiando la línea

{% highlight c %}
int jpeg_load_from_mem(unsigned char*_data, int size, unsigned char*dest, int width, int height)
{% endhighlight %}

por esta otra:

{% highlight c %}
int jpeg_load_from_mem(unsigned char*_data, int size, unsigned char**dest, int *width, int *height)
{% endhighlight %}
