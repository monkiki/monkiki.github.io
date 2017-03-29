---
layout: post
title: "Utilizar un servo con Arduino"
date: 2017-03-29
sources:
- https://programarfacil.com/tutoriales/fragmentos/servomotor-con-arduino/
categories:
- Arduino
---

Vamos a ver cómo usar el servo SG90 con Arduino. Lo primero que debemos saber es para qué sirve cada
uno de los tres cables que tiene este componente. Según la [ficha técnica del producto](http://www.micropik.com/PDF/SG90Servo.pdf) 
ésta es la función de cada uno de ellos:

 | SG90    | Arduino  |
 | ------- | -------- |
 | Naranja | PWM      |
 | Rojo    | Vcc (5V) |
 | Marrón  | GND      |

La forma de usar el servo en Arduino es muy simple gracias a la librería **Servo**. Y nada mejor que
verlo en funcionamiento con un ejemplo. Este código lo que hacer es mover el servo de 0 a 180 grados,
esperar 15 milisegundos y volver de estos 180 grados a los 0 iniciales. Y vuelta a empezar. Para que
funcione tienes que conectar el cable naranja al pin 9 de tu Arduino.

{% highlight c %}
#include <Servo.h>
 
Servo myservo;
int pos = 0;
 
void setup() {
  myservo.attach(9);  // attach servo on pin 9
}

void loop() {
  for(pos = 0; pos < 180; pos += 5) {
    myservo.write(pos);
    delay(15);
  }
  
  for(pos = 180; pos >=1 ; pos -= 5) {
    myservo.write(pos);
    delay(15);
  }
}
{% endhighlight %}

Sencillo, ¿verdad?
