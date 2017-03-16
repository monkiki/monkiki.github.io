---
author: monkiki
comments: true
date: 2009-09-18 12:11:40+00:00
layout: post
link: https://monkiki.wordpress.com/2009/09/18/comparaciones-de-cadenas-en-mysql/
slug: comparaciones-de-cadenas-en-mysql
title: Comparación de cadenas en MySQL
wordpress_id: 35
categories:
- Ubuntu
tags:
- mysql
---

Hoy he flipado en colores: resulta que MySQL evalúa

{% highlight sql %}
select 'A'='a'
{% endhighlight %}

a true. O sea, que para él son iguales. Para que haga la compración _Como Dios Manda (tm)_ lo tienes que escribir así:

{% highlight sql %}
select 'A' like binary 'a'
{% endhighlight %}

Lo más triste es descubrir esto después de tantos años trabajando con esta base de datos. Y lo he descubierto porque me he equivocado escribiendo el nombre de usuario en un OpenKM que estoy montando.

Repito, flipo.
