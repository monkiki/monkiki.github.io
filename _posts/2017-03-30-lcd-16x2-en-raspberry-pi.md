---
layout: post
title: "LCD 16x2 en Raspberry Pi"
date: 2017-03-30
sources:
- http://skpang.co.uk/blog/archives/575
- http://www.funwithpi.us/2016/02/05/hourly-chime/
- http://www.instructables.com/id/Raspberry-Pi-Rooster-Clock/?ALLSTEPS
- https://bitbucket.org/MattHawkinsUK/rpispy-misc/raw/master/python/lcd_i2c.py
categories:
- Raspberry Pi
---

Recientemente he necesitado usar un display para uno de mis proyectos. Por coste y facilidad de uso
me he decantado por un LCD1602 que, como su propio nombre indica, se trata de una pantalla LCD que
permite mostrar 2 líneas de 16 caracteres cada una. Además está retroiluminado.

Si lo usamos directamente, necesitaremos un montón de conexiones (unos 11 cables) y es poco práctico.
De modo que está la opción que incluye un adaptador I2C lo cual reduce el número de conexiones a cuatro
(dos de alimentación y dos de control).

Pero... qué es I2C? Pues se trata de un bus serie que nos permite conectar varios dispositivos a un
controlador con sólo dos líneas: CLK (Serial Clock) y SDA (Serial Data). Cada dispositivo tiene una
dirección predeterminada que se usa para poderse comunicar con él. 

El el artículo [RTC DS3231 en Raspberry Pi]({% post_url 2017-03-22-rtc-ds3231-en-raspberry-pi %}) ya
explicamos como configurar el protocolo I2C en la Raspberry, de modo que no vamos a repetir lo mismo.
Lo único a tener en cuenta es que, en este caso, el único módulo que tenemos que añadir al fichero
**/etc/modules** es el **i2c-dev**. Y que si queremos que un determinado usuario pueda usar el dispositivo
I2C debe pertenecer al grupo **i2c**:

{% highlight bash %}
$ sudo adduser pi i2c
{% endhighlight %}

## Ejemplo de uso
Antes de probar el ejemplo tenemos que ver la dirección del módulo con el comando:

{% highlight bash %}
$ sudo i2cdetect -y 1
{% endhighlight %}

Y esa dirección hexadecimal será la que pongamos en la variable **I2C_ADDR**. El ejemplo es un poco largo
porque accede a display a bajo nivel. Seguramente hay alguna librería que simplifica el código, como la
hay para Arduino, pero a unas malas es sencillo hacer una.

{% highlight python %}
#!/usr/bin/python

from datetime import datetime
import smbus
import time

# Define some device parameters
I2C_ADDR = 0x3F  # I2C device address
LCD_WIDTH = 16  # Maximum characters per line

# Define some device constants
LCD_CHR = 1  # Mode - Sending data
LCD_CMD = 0  # Mode - Sending command

LCD_LINE_1 = 0x80  # LCD RAM address for the 1st line
LCD_LINE_2 = 0xC0  # LCD RAM address for the 2nd line
LCD_LINE_3 = 0x94  # LCD RAM address for the 3rd line
LCD_LINE_4 = 0xD4  # LCD RAM address for the 4th line

LCD_BACKLIGHT = 0x08  # On
# LCD_BACKLIGHT = 0x00  # Off

ENABLE = 0b00000100  # Enable bit

# Timing constants
E_PULSE = 0.0005
E_DELAY = 0.0005

# Open I2C interface
# bus = smbus.SMBus(0)  # Rev 1 Pi uses 0
bus = smbus.SMBus(1)  # Rev 2 Pi uses 1


def lcd_init():
    # Initialise display
    lcd_byte(0x33, LCD_CMD)  # 110011 Initialise
    lcd_byte(0x32, LCD_CMD)  # 110010 Initialise
    lcd_byte(0x06, LCD_CMD)  # 000110 Cursor move direction
    lcd_byte(0x0C, LCD_CMD)  # 001100 Display On,Cursor Off, Blink Off
    lcd_byte(0x28, LCD_CMD)  # 101000 Data length, number of lines, font size
    lcd_byte(0x01, LCD_CMD)  # 000001 Clear display
    time.sleep(E_DELAY)


def lcd_byte(bits, mode):
    # Send byte to data pins
    # bits = the data
    # mode = 1 for data
    #        0 for command

    bits_high = mode | (bits & 0xF0) | LCD_BACKLIGHT
    bits_low = mode | ((bits << 4) & 0xF0) | LCD_BACKLIGHT

    # High bits
    bus.write_byte(I2C_ADDR, bits_high)
    lcd_toggle_enable(bits_high)

    # Low bits
    bus.write_byte(I2C_ADDR, bits_low)
    lcd_toggle_enable(bits_low)


def lcd_toggle_enable(bits):
    # Toggle enable
    time.sleep(E_DELAY)
    bus.write_byte(I2C_ADDR, (bits | ENABLE))
    time.sleep(E_PULSE)
    bus.write_byte(I2C_ADDR, (bits & ~ENABLE))
    time.sleep(E_DELAY)


def lcd_string(message, line):
    # Send string to display
    message = message.ljust(LCD_WIDTH, " ")
    lcd_byte(line, LCD_CMD)

    for i in range(LCD_WIDTH):
        lcd_byte(ord(message[i]), LCD_CHR)


def main():
    # Initialise display
    lcd_init()

    while True:
        # Send current time
        str_time = datetime.now().strftime("%H:%M:%S")
        lcd_string(str_time, LCD_LINE_1)
        lcd_string("", LCD_LINE_2)

        time.sleep(1)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
    finally:
        lcd_byte(0x01, LCD_CMD)
{% endhighlight %}

