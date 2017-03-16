---
author: monkiki
comments: true
date: 2015-02-09 17:50:40+00:00
layout: post
link: https://monkiki.wordpress.com/2015/02/09/liveconnect-y-linux-2/
slug: liveconnect-y-linux-2
title: LiveConnect y Linux (2)
wordpress_id: 247
categories:
- Debian
- Java
- Ubuntu
tags:
- Javascript
- JDK
- linux
- liveconnect
- Oracle
---

Después de unos días, me comenta Jaime Hablutzel que existe una forma de que funcione con las últimas versiones de Java. La solución es ir al **Java Control Panel** y en **Java Runtime Environment Settings** añadir el parámetro:

{% highlight java%}
-Djnlp.nativeMixedCodeDialog=false
{% endhighlight %}

Aquí una captura de pantalla:

<center><img src="/assets/posts/2015/02/liveconnect.png" width="540px"/></center>
