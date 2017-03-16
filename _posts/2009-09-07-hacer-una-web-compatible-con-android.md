---
author: monkiki
comments: true
date: 2009-09-07 13:16:17+00:00
layout: post
link: https://monkiki.wordpress.com/2009/09/07/hacer-una-web-compatible-con-android/
slug: hacer-una-web-compatible-con-android
title: Hacer una web compatible con Android.
wordpress_id: 21
categories:
- Android
---

Quizás el título no sea todo lo descriptivo que debiera ser ya que, en principio, cualquier web se puede visualizar en el navegador que viene por defecto en Android. Pero al ser tan pequeña la pantalla del dispositivo, no quedarán tan bien como en nuestro ordenador de escritorio.

Vayamos al grano. Una particularidad de los móviles con Android es que cambian a modo apaisado los giramos. De esta forma se pueden ver un poco mejor las webs normales al tener más ancho disponible. Nosotros, como vamos a hacer una web especialmente para Android tenemos que tener en cuenta esto. Hay que aprovechar todo el espacio que se pueda :)

El siguiente código es una página que muestra si el navegador está en modo apaisado o vertical gracias a la propiedad de **orientation** del objeto **window** de javascript. Este valor varía entre 0 (vertical) y 90 (apaisado). Si vamos tumbando y levantando el móvil al recargar la página nos muestra la orientación.

(Nota: Para acceder al servidor web instalado en tu ordenador desde el emulador de Android ve a [http://10.0.2.2/](http://10.0.2.2/) )

{% highlight html %}
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <script type="text/javascript">
    window.addEventListener("load", function() { setTimeout(loaded, 100) }, true);
    function loaded() {
      if (window.orientation == 90) {
        document.getElementById('orientacion').innerText = 'apaisado';
      } else {
        document.getElementById('orientacion').innerText = 'vertical';
      }
    }
  </script>
</head>
<body>
 
<b>Orientacion:</b> <span id="orientacion"></span>
</body>
</html>
{% endhighlight %}

Pero bueno, esto es útil cuando entre un usuario en la página. ¿Pero que pasa si el usuario cambia la orientación del navegador luego? ¿Tiene que volver a recargar para la página lo dectecte? La respuesta corta es que si, pero ciertamente es muy cutre.

El navegador de iPhone (que al igual que el de Android está basado en Webkit) implementa un evento llamado **onOrientationChange**, que ya os podéis imaginar lo últil que es para dectectar esos cambios de orientación. El amigo Android nos lo pone más complicado... Pero sólo un poco :) Sólo tenemos que ir comprobado si hay cambios en la orientación continuamente:

{% highlight html %}
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript">
  var previa = -1;
  window.addEventListener("load", function() { setTimeout(loaded, 100) }, true);
  function loaded() {
    if (previa != window.orientation) {
      if (window.orientation == 90) {
        document.getElementById('orientacion').innerText = 'horizontal';
      } else {
        document.getElementById('orientacion').innerText = 'vertical';
      }
      previa = window.orientation;
    }
    setTimeout(loaded, 100);
  }
</script>
</head>
<body>
  <b>Orientación:</b> <span id="orientacion"></span>
</body>
</html>
{% endhighlight %}

Ale, a jugar!
