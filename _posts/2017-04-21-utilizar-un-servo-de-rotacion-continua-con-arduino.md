---
layout: post
title: "Utilizar un servo de rotación continua con Arduino"
date: 2017-04-21
sources:
- https://www.luisllamas.es/controlar-un-servo-de-rotacion-continua-con-arduino/
categories:
- Arduino
---

En otro post anterior vimos como controlar un servo de los "normales" con Arduino. Este tipo de servo
tienen una limitación y es que sólo permiten girar entre 0 y 180 grados. Hay casos en los que necesitamos
tener una libertad de movimiento de 360 grados, y es aquí donde entran en escena los servos de rotación
continua. La parte negativa es:

* Son más caros.
* No podemos controlar la posición.
* No dispondremos de un control preciso de la velocidad.

Sin embargo, y dependiendo del uso que le demos, podremos vivir con estos inconvenientes.

He encontrado tutoriales en los que convierten un SG90 en uno de rotación continua, pero corres el peligro
de romper el servo. Ademas, el rendimiento no es equiparable al de un servo comercial. Por tanto está la
opción de comprar un FS90R que, por poco más de 3 euros en Aliexpress, no ahorra toda esa película.
Según la [ficha técnica del producto](https://cdn-shop.adafruit.com/product-files/2442/FS90R-V2.0_specs.pdf)
las conexiones con estas:

 | FS90R   | Arduino  |
 | ------- | -------- |
 | Naranja | PWM      |
 | Rojo    | Vcc (5V) |
 | Marrón  | GND      |

La forma de usar un servo de rotación continua es igual a la de un servo normal, por lo que también
haremos uso de la librería **Servo**. Veamos un ejemplo de uso en el que podemos ver que, según el
ángulo de rotación podemos cambiar tanto la velocidad de rotación como el sentido de giro.

{% highlight c %}
#include <Servo.h>

Servo myservo;  // create servo object to control a servo 
 
void setup() {
  Serial.begin(9600);
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object
}

void loop() {
  // Servo 100% CW (angle 0 degrees)
  Serial.println("100% CW");
  myservo.write(0);
  delay(1500); 
  
  // Servo stopped(angle 90 degrees)
  Serial.println("Stop");
  myservo.write(90);
  delay(1500);

  // Servo 100% CCW (angle 180 degrees)
  Serial.println("100% CCW");
  myservo.write(180);
  delay(1500);
}
{% endhighlight %}

Y poco más.
