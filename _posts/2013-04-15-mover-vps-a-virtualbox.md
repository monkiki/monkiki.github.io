---
author: monkiki
comments: true
date: 2013-04-15 08:45:11+00:00
layout: post
link: https://monkiki.wordpress.com/2013/04/15/mover-vps-a-virtualbox/
slug: mover-vps-a-virtualbox
title: Mover VPS a VirtualBox
wordpress_id: 213
categories:
- Debian
tags:
- dd
- gzip
- hetzner
- linux
- nc
- netcat
- Ubuntu
- virtualbox
- vps
---

Vamos a ver los pasos necesarios para mover un servidor VPS a un máquina virtual local con VirtualBox.

Primero vamos a replicar el disco del servidor a nuestro ordenador. Para ello vamos a usar las herramienta **netcat** y **dd**. Antes de nada decir que para que funcione lo mejor posible, ninguna partición del disco debe estar montada. Para ello se debe arrancar desde otro disco. En mi caso que uso [Hetzner](http://www.hetzner.de/en/), desde la consola de administración (ellos los llaman **robot**) permite arrancar el VPS en **modo rescue**.

Una vez hecho esto, en la máquina destino ejecutamos lo siguiente:

{% highlight bash %}
$ nc -v -l 5525 > srvdisk.gz
{% endhighlight %}

En el servidor esto:

{% highlight bash %}
$ dd if=/dev/sda conv=sync,noerror bs=16M | gzip | nc -v -q 0 host.dst.ip 5525
{% endhighlight %}

Una vez clonado el disco, lo descomprimimos:

{% highlight bash %}
$ gunzip srvdisk.gz
{% endhighlight %}

Y vemos las particiones que tiene:

{% highlight bash %}
$ fdisk -l srvdisk
{% endhighlight %}

Por último lo convertimos a formato VDI para poder usarlo desde VirtualBox:

{% highlight bash %}
$ vboxmanage convertfromraw srvdisk srvdisk.vdi
{% endhighlight %}

Una vez creado el disco para VirtualBox creamos una nueva máquina virtual y le decimos que use este disco convertido.

Por último habrá que hacer algunos ajustes en la configuración de Linux para que funcione correctamente. En mi caso el proveedor de hosting es [Hetzner](http://www.hetzner.de/en/) y el VPS va con [Ubuntu 12.04](http://www.ubuntu.com/), por lo que los cambios fueron los siguientes:

  * En el fichero **/etc/apt/sources.list** comentar los repositorios de Hetzner y poner los de Ubuntu:

{% highlight apt %}
deb http://es.archive.ubuntu.com/ubuntu precise main restricted universe multiverse
deb http://es.archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse
deb http://es.archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu precise-security main restricted universe multiverse
{% endhighlight %}

  * En el fichero **/etc/resolv.conf** comentar los nameserver de Hetzner y poner los de Google:

{% highlight dns %}
nameserver 8.8.8.8
nameserver 8.8.4.4
{% endhighlight %}

  * En el fichero **/etc/network/interfaces** comentar la configuración de red de Hetzner y poner la que mejor se adapte.

{% highlight net %}
auto eth0
iface eth0 inet static
  address 192.168.0.100
  broadcast 192.168.0.255
  netmask 255.255.255.0
  gateway 192.168.0.1
{% endhighlight %}

  * En el fichero /etc/udev/rules.d/70-persistent-net.rules comentar la primera línea de Hetzner donde viene la MAC de la tarjeta del VPS y que quede de esta forma (La segunda entrada se añadirá automáticamente y el parámetro ATTR{address} será diferente ya que se trata de la MAC de la tarjeta de red de la máquina virtual de VirtualBox. Lo importante es que el parámetro NAME sea "eth0".):

{% highlight usb %}
# device: eth0
#SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:1c:14:01:4f:68", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"
# PCI device 0x8086:/sys/devices/pci0000:00/0000:00:03.0 (e1000)
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="08:00:27:b9:04:bf", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"
{% endhighlight %}

Y con todo esto ya podríamos usar el VPS localmente.
