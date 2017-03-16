---
author: monkiki
comments: true
date: 2009-09-25 13:26:38+00:00
layout: post
link: https://monkiki.wordpress.com/2009/09/25/dependencias-en-maven/
slug: dependencias-en-maven
title: Dependencias en maven
wordpress_id: 43
categories:
- Java
tags:
- maven
---

Es malo incluir la libraría log4j.jar en una aplicación deployada en JBoss por ya la trae él y hay temas de classpath. Vamos, que se hace un follón con las dos versiones.

Especial cuidado hay que tener por las dependencias transitivas de maven: tu no la incluyes a posta en el pom.xml de tu projecto pero se cuela en el war porque forma parte de una dependencia de otra librería que necesitas.

Te puedes volver loco buscando qué dependencia es es culpable de que se incluya esa librería. Pero hay una solución perfecta para ello:

{% highlight bash %}
$ mvn dependency:tree
{% endhighlight %}

Esto muestra todo el árbol de dependencias y podrás ver de dónde cuelga. Luego simplemente tienes que añadir la exclusión de dicha librería en la dependencia _maligna_:

{% highlight xml %}
<exclusions>
  <!-- JBoss already have its own log4j.jar -->
  <exclusion>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
  </exclusion>
</exclusions>
{% endhighlight %}
