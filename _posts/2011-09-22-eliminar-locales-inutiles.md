---
author: monkiki
comments: true
date: 2011-09-22 09:56:12+00:00
layout: post
link: https://monkiki.wordpress.com/2011/09/22/eliminar-locales-inutiles/
slug: eliminar-locales-inutiles
title: Eliminar locales inútiles
wordpress_id: 206
categories:
- Debian
- Ubuntu
tags:
- i18n
- l10n
- locale
---

Cuando instalas Ubuntu, tiene la manía de configurar una cantidad de locales absurda. Por ejemplo, cuando haces una instalación para Español de España, además te instala los locales para todas las variantes del Español. Y hay muchas. Esto es bastante molesto cuando usas el corrector ortográfico de Firefox, que cuando quieres elegir el idioma te salen la tira.

Para mejorar esto, hay que hacer dos cosas. Por una parte instalar el paquete **localpurge**:

{% highlight bash %}
$ sudo apt-get install localepurge
{% endhighlight %}

Que te dará a elegir qué locales quieres conservar, cepilándose el resto.

Por otra parte, para eliminar variantes que no usas en Firefox, ve a la carpeta **/usr/lib/firefox-6.0.2/dictionaries** y borra los que no vayas a usar. En el caso del Español por lo menos, la cosa tiene su gracia pq todas las variantes de este idioma apuntan a un mismo fichero de diccionario, con lo cual es totalmente absurdo.

Fuentes:
	
  * [Tip: Elimina los diccionarios que no ocupas en Firefox 5.0](http://www.glatelier.org/2011/08/tip-elimina-los-diccionarios-que-no-ocupas-en-firefox-5-0/)
  * [How to select and generate locales on Ubuntu](http://www.ubuntugeek.com/how-to-select-and-generate-locales-on-ubuntu.html)
  * [LocaleConf](https://help.ubuntu.com/community/LocaleConf)
