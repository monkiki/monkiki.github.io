---
layout: post
title: "Nueva plataforma y migración"
date: 2017-03-16
published: true
---

Después de un tiempo sin escribir nada he decidido a retomar el blog, pero para cambiar un poco
me dispuse a buscar alternativas a [wordpress.com](http://wordpress.com) y finalmente topé con una
herramienta de publicación estática llamada [Jekyll](https://jekyllrb.com/). De este tipo de herramientas
es la más usada y [GitHub Pages](https://pages.github.com/) permite publicar contenido haciendo
uso de ella.

No obstante no quería empezar de cero y estuve investigando cómo migrar los contenidos del otro blog.
Básicamente hay dos formas de hacerlo:

* Exportar el contenido desde [wordpress.com](http://wordpress.com) (en formato XML) y usar alguno de
los múltiples scripts que lo convierten al formato correspondiente.

* Instalar plugin en Wordpress que genera ya una exportación en el formato de Jekyll.

La primera opción es la que menos trabajo entraña, ya que es sólo exportar el XML y convertir. Yo he usado
el script [ExitWP](https://github.com/thomasf/exitwp) con bastante buenos resultados. Lo malo es que las 
imágenes siguen apuntando al blog antiguo. En mi caso no resultó un problema pq tengo pocas.

La segunda opción sí que exporta las imágenes, pero implica tener que montar un Wordpress en local ya
que la versión de Wordpress.com no admite la instalación de plugins. El que probé fue
[Jekyll Exporter](https://wordpress.org/plugins/jekyll-exporter). Para que funcione hay que instalar
algunos paquetes:

{% highlight bash %}
$ sudo apt-get install php-mbstring php-zip
{% endhighlight %}

Al invocar la exportación bajará directamente un ZIP con el contenido en formato Jekyll.

En cualquier caso no está de más pegar un ojo a los artículos exportados para verificar que todo ha ido
bien. Como suelo tener trozos de código tuve que cambiarlos para que hicieran uso de la [funcionalidad
de resaltado de sintaxis](https://jekyllrb.com/docs/templates).

Respecto al diseño he optado por algo sencillo usando [Bootstrap](http://getbootstrap.com/). Lo iré
mejorando con el tiempo y añadiendo funcionalidades según vaya aprendiendo a usar esta herramienta 
de publicación.
