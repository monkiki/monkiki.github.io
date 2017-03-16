---
author: monkiki
comments: true
date: 2010-02-09 17:47:20+00:00
layout: post
link: https://monkiki.wordpress.com/2010/02/09/instalacion-y-uso-del-dni-electronico-en-ubuntu/
slug: instalacion-y-uso-del-dni-electronico-en-ubuntu
title: Instalación y uso del DNI electrónico en Ubuntu
wordpress_id: 93
categories:
- Ubuntu
tags:
- dnie
---

Supongamos que tenemos un DNI electrónico y un lector compatible. Veamos cómo hacerlo funcionar en _Ubuntu Linux Karmic Koala_. No te asuste que es más fácil de lo que pueda parecer.

En primer lugar hay que dirigirse al [Portal Oficial sobre el DNI electrónico](http://www.dnielectronico.es/) para descargar los paquetes para nuestro [Sistema Operativo favorito](http://www.dnielectronico.es/descargas/PKCS11_para_Sistemas_Unix/opensc_1.4.6_menu32.html) que, por esta vez, los señores del Gobierno Español han tenido a bien ofrecernos. A día de hoy están disponibles para Ubuntu Jaunty Jackalope, pero funcionarán en Karmic Koala sin problemas.

Hay un archivo TAR donde se encuentran 3 paquetes, los cuales deben instalarse en el siguiente orden:

  * libopensc2_0.11.7-7_i386.deb
  * opensc_0.11.7-7_i386.deb
  * opensc-dnie_1.4.6-2_i386.deb

Como en Karmic vienen versiones más nuevas de estos paquetes, tendremos que bloquearlos para que no se actualicen de formas automática y todo deje de funcionar:

{% highlight bash %}
$ echo -e "opensc hold\nlibopensc2 hold" | sudo dpkg --set-selections
{% endhighlight %}

Adicionalmente también te aconsejo instalar los siguientes paquetes:

{% highlight bash %}
$ sudo aptitude install libccid libpcsclite1 pcscd pinentry-gtk2 mozilla-opensc pcsc-tools
{% endhighlight %}

Ahora enchufamos el aparato y comprobamos que lo puede usar:

{% highlight bash %}
$ pcsc_scan
{% endhighlight %}

Debe salir algo como:

{% highlight text %}
PC/SC device scanner
V 1.4.15 (c) 2001-2009, Ludovic Rousseau <ludovic.rousseau@free.fr>
Compiled with PC/SC lite version: 1.4.102
Scanning present readers...
0: SCM SCR 3310 00 00

Tue Feb  9 18:34:05 2010
 Reader 0: SCM SCR 3310 00 00
 Card state: Card removed,
{% endhighlight %}

Y si insertamos el DNIe parpadeará la luz verde del lector y saldrán algunos mensajes más en la consola.

Ahora veamos como configurar Firefox para que podamos acceder a las aplicaciones web que hacen uso de esta tenología. Cuando instalaste el paquete opensc-dnie, se creó una nueva entrada en el menú localizada en **_Aplicaciones > Oficina > Registrar módulo DNIe PKCS#11_**. De modo que hacemos click ahí y se abrirá una ventana en el navegador como esta:

<center><img src="/assets/posts/2010/02/descargando-certificado1.png" width="540px"/></center>

en la que deberemos marcar todos los checkbox y darle a Aceptar. Puedes ver cómo se ha añadido el certificado en **_Editar > Preferencias > Avanzado > Cifrado > Ver certificados > Autoridares > DIRECCION GENERAL DE LA POLICIA_**. Ahora ya estás listo para probar tu DNIe, de modo que ve a [compruebe su DNI](http://www.dnielectronico.es/como_utilizar_el_dnie/verificar.html) (si te da un error de **Conexión segura fallida** prueba con el [Censo Electoral](https://censoelectoral.ine.es/)).

Más info en:

  * [DNIe en Ubuntu 9.10 Karmic Koala](http://nauj27.com/blog/2009/11/17/dnie-en-ubuntu-9-10-karmic-koala)
  * [Instalación del DNI electrónico en Ubuntu](http://www.tuxapuntes.com/drupal/node/1373)
  * [INTECO: DNI Electrónico](http://www.inteco.es/Seguridad/DNI_Electronico/Guias_y_Documentos/Lectores_DNIe/Instalacion_lectores/Ubuntu/)
