---
author: monkiki
comments: true
date: 2010-03-30 17:58:04+00:00
layout: post
link: https://monkiki.wordpress.com/2010/03/30/captura-y-edicion-de-video-con-ubuntu/
slug: captura-y-edicion-de-video-con-ubuntu
title: Captura y edición de vídeo con Ubuntu
wordpress_id: 128
categories:
- Ubuntu
tags:
- audio
- multimedia
- video
---

Hago vídeos muy de cuando en cuando y luego resulta que no me acuerdo exactamente cómo los edité en Linux. Además que antes usaba [Kino](http://www.kinodv.org/) y ahora hay aplicaciones más simples de usar como [OpenShot](http://www.openshotvideo.com/) o [Pitivi](http://www.pitivi.org/).

Como mi cámara tiene ya sus añitos, no graba directamente en MPEG por lo que es necesario importar ese vídeo hacia el ordenador usando Firewire ([IEEE 1394](http://es.wikipedia.org/wiki/IEEE_1394)). Además que el vídeo está entrelazado. Debido a un pequeño lío de permisos con el dispositivo de captura, es necesario hacerlo como root para simplificar:

{% highlight bash %}
$ sudo dvgrab -a -f avi
{% endhighlight %}

Así irá generando ficheros en formato AVI divididos por escenas, ya que es mejor troceado que un pedazo de fichero enorme.

**Nota:** *Según he podido comprobar empíricamente, da mejores resultados hacer un desentrelazado previo y trabajar con estos vídeos mejorados en Pitivi:*

{% highlight bash %}
$ ffmpeg -i dvgrab-xxx.avi -threads 0 -deinterlace -vcodec huffyuv -pix_fmt yuv422p -acodec copy di_dvgrab-xxx.avi
{% endhighlight %}

Para la edición y montaje he preferido usar Pitivi, que aunque tiene menos funcionalidades que OpenShot, ha demostrado ser más estable. Además el formato de los ficheros proyectos es XML con lo que en un momento dado puedes tocarlo si has cambiado los ficheros de lugar. Parece una tontería, pero me ha pasado algunas veces.

Como Pitivi es más bien limitadito, lo único que haremos será juntar los trozos de vídeo haciendo un fade-in / fade-out manual, o sea, editando la línea roja de nivel añadiendo puntos de inflexión con un doble click. Es más complicado de describir que de hacer. Y si queremos ponerle carátula y créditos al final, con Gimp se puede hacer una imagen que se puede insertar en el vídeo. El tamaño adecuado lo conseguimos en **Archivo > Nuevo > Plantilla > PAL - 720x576**.

El renderizado del proyecto lo haremos en formato OGG (theoraenc, vorbisenc), que es el formato que viene establecido por defecto. El fichero resultante es gordito, pero con poca pérdida de calidad. Luego lo pondremos a dieta.

Por último vamos a codificar la película resultante con [HandBrake](http://handbrake.fr/), con el que además de conseguir un nivel de compresión chachi sin pérdida notable de calidad también desentrelazará las imágenes quedando listo para regalo. En formato elegimos **MP4** y en **Presets** la opción **Regular > High Profile**.

**Nota:** *Si hemos hecho el desentrelazado previamente como recomendábamos, basta con seleccionar el perfil **Regular > Normal**.*

**Nota 2:** *Mi cámara tiene la posibilidad de grabar en formato 16:9 y entonces la cosa cambia:*

{% highlight bash %}
$ sudo dvgrab -a -f avi
$ ffmpeg -i dvgrab-xxx.avi -threads 0 -deinterlace -vcodec huffyuv -pix_fmt yuv422p -acodec copy -aspect 16:9 di_dvgrab-xxx.avi
{% endhighlight %}

*El amigo Pitivi tiene problemas para trabajar con este formato (los vídeos salen estirados como un churro) y no me queda otra que trabajarlos con OpenShot, el cual he podido comprobar gratamente que funciona mejor con esta última versión.*

**Nota 3:** *Vale, pues otro descubrimiento más. Si lo desentrelazo así:*

{% highlight bash %}
$ ffmpeg -i dvgrab-xxx.avi -threads 0 -deinterlace -vcodec huffyuv -pix_fmt yuv422p -acodec copy -aspect 16:9 -s 720x406 di_dvgrab-xxx.avi
{% endhighlight %}

*Sí que funciona correctamente con Pitivi. El detalle es forzar el tamaño final de la imagen, que es como debería ser.*
