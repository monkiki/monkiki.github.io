---
layout: post
title: "RTC DS3231 en Raspberry Pi"
date: 2017-03-22
sources:
- https://trick77.com/adding-ds3231-real-time-clock-raspberry-pi-3/
- http://www.raspberrypi-spy.co.uk/2015/05/adding-a-ds3231-real-time-clock-to-the-raspberry-pi/
- https://learn.adafruit.com/adafruits-raspberry-pi-lesson-4-gpio-setup/configuring-i2c
categories:
- Raspberry Pi
---

Me he visto envuelto en un proyecto que requiere que el reloj de la Raspberry Pi esté siempre en hora.
Este dispositivo no dispone de un RTC (Real Time Clock), por lo que cada vez que se apaga
se pierde la hora y en el inicio la intenta recuperar a través de Internet haciendo uso del protocolo NTP.

En este caso, el dispositivo no tendrá acceso a Internet de modo que se las tendrá que apañar por sí sólo.
Suerte que hace poco compré un módulo DS3231 en Aliexpress, que es la pieza que faltaba en el puzzle. Por
tanto paso a detallar la configuración del mismo, que tiene su miga.

Lo primero es saber conectarlo, cosa que se indica en esta tabla:

 | DS1307 | Pi GPIO         |
 | ------ | --------------- |
 | GND    | P1-06           |
 | Vcc    | P1-01 (3.3V)    |
 | SDA    | P1-03 (I2C SDA) |
 | SCL    | P1-05 (I2C SCL) |

Una vez conectado, instalamos el paquete **i2c-tools**:

{% highlight bash %}
$ sudo apt-get install i2c-tools
{% endhighlight %}

Añadimos los siguientes módulos (en el fichero **/etc/modules**):

{% highlight text %}
snd-bcm2835
i2c-bcm2835
i2c-dev
rtc-ds1307
{% endhighlight %}

En las versiones de kernel más recientes es necesario añadir un par de líneas al final del fichero **/boot/config.txt**:

{% highlight text %}
dtparam=i2c1=on
dtparam=i2c_arm=on
{% endhighlight %}

Una vez hecho todo esto reiniciamos la Raspberry.

Ahora vamos a ver todos los dispositivos I2C conectados:

{% highlight bash %}
$ sudo i2cdetect -y 1
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- 57 -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- 68 -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         
{% endhighlight %}

Según esta información, el "68" es la dirección hexadecimal del módulo RTC en el interface I2C. Para 
asegurarnos que se configure en cada inicio y que se establezca la hora correcta editamos el fichero
**/etc/rc.local** y añadimos lo siguiente:

{% highlight bash %}
echo ds1307 0x68 > /sys/class/i2c-adapter/i2c-1/new_device
hwclock -s
{% endhighlight %}

Volvemos a reiniciar y comprobamos si todo ha ido bien viendo si cargó el módulo RTC:

{% highlight bash %}
$ dmesg | grep rtc
[   10.244652] rtc-ds1307 1-0068: rtc core: registered ds1307 as rtc0
[   10.244712] rtc-ds1307 1-0068: 56 bytes nvram
{% endhighlight %}

Y ya está todo. Si desconectas la Raspberry de Internet podrás comprobar que cada vez que arranque
tandrá la hora correcta.

## Información adicional

Podemos obtener más información sobre el dispositivo RTC de esta forma:

{% highlight bash %}
$ cat /proc/driver/rtc
{% endhighlight %}

Para establecer la hora del sistema desde el dispositivo RTC:

{% highlight bash %}
$ sudo hwclock -s
{% endhighlight %}

Para escribir la fecha y hora desde al dispositivo RTC:

{% highlight bash %}
$ sudo hwclock -w
{% endhighlight %}

Para leer la fecha y hora desde el dispositivo RTC:

{% highlight bash %}
$ sudo hwclock -r
{% endhighlight %}
