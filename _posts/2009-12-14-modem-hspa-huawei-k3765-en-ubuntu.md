---
author: monkiki
comments: true
date: 2009-12-14 17:02:50+00:00
layout: post
link: https://monkiki.wordpress.com/2009/12/14/modem-hspa-huawei-k3765-en-ubuntu/
slug: modem-hspa-huawei-k3765-en-ubuntu
title: Modem HSPA Huawei K3765 en Ubuntu
wordpress_id: 60
categories:
- Ubuntu
---

Ha llegado a mis manos un modem 3G de esos que son tan populares ahora. Se trata de un Huawei K3765 de Vodafone. Y claro, si no funciona con Ubuntu de poco me puede servir. Estamos hablando de _Ubuntu Karmic Koala_, para ser más exactos.

**Nota:** Para *Ubuntu Lucid Lynx* basta con instalar el paquete *usb-modeswitch* y configurar la conexión en el NetworkManager.

Después de googlear un poco, he encontrado esta página [https://forge.betavine.net/projects/vodafonemobilec/](https://forge.betavine.net/projects/vodafonemobilec/) en la que hay unos paquetes que ayudarán a que podamos poner este cacharro en funcionamiento desde nuestra distro de Linux favorita.

Vemos que hay un apartado dedicado a Ubuntu, de modo que descargaremos los paquetes de esa sección. Hay que bajarse estos:

  * [ozerocdoff_0.4-2_i386.deb](https://forge.betavine.net/frs/download.php/538/ozerocdoff_0.4-2_i386.deb)
  * [usb-modeswitch_0.9.7_i386.deb](https://forge.betavine.net/frs/download.php/490/usb-modeswitch_0.9.7_i386.deb)
  * [vodafone-mobile-connect_2.15.01-2_all.deb](https://forge.betavine.net/frs/download.php/583/vodafone-mobile-connect_2.15.01-2_all.deb)

Una vez instalados y resueltas las dependencias podremos enchufar el dispositivo y ejecutar el programa "Vodafone Mobile Connect" que gestiona la conexión. Por si no lo encuentras, está dentro del menú "Internet", como es lógico :)

En ese programa nos pide el PIN para acceder a la tarjeta alojada dentro del modem. El resto es fácil porque la aplicación es bastante intuitiva. Como nota de interés la aplicación también permite enviar SMS, lo cual es muy cómodo con un teclado decente.
