---
author: monkiki
comments: true
date: 2010-03-12 15:01:54+00:00
layout: post
link: https://monkiki.wordpress.com/2010/03/12/personalizacion-de-campos-en-mantis/
slug: personalizacion-de-campos-en-mantis
title: Personalización de campos en Mantis
wordpress_id: 118
categories:
- Ubuntu
---

Mantis es un gestor de bugs (bugtracking system) escrito en PHP que llevo usando desde hace años. Visualmente no es gran cosa pero funciona realmente bien y es lo bastante flexible como para adaptarse a las necesidades que he ido teniendo. Últimamente lo he configurado para añadir un nuevo campo a los bugs que se van reportando en el gestor documental OpenKM.

Vamos a _Manage > Manage Custom Fields_. En el input escribimos el nombre del nuevo campo que en este caso sería **Browser**. Saltará a una nueva página en la que podemos describir los parámetros del este campo, como el tipo, posibles valores, etc. Elegimos el tipo **Enumeration** porque queremos que sea un desplegable desde donde el usuario podrá seleccionar el nombre del navegador. Así agilizamos la entrada de datos y eliminamos posibles errores de escritura. Y dentro de posibles valores escribe:

{% highlight text %}
|Firefox|Explorer|Chrome|Safari|Opera
{% endhighlight %}

Como ves, los distintos valores se separan por el carácter pipe. El primero al no haber nada representa el valor vacío. El resto de opciones las podemos dejar tal y como están.

Un poco más abajo hay otro formulario que permite ligar este campo a un proyecto. De esta forma cada proyecto puede tener sus propios campos personalizados. Este campo aparecerá por defecto al final. Si nos va bien así ya hemos acabado, pero si eres un poco quisquilloso y quieres que aparezca esta nueva columna en el listado de bugs tendrás que sequir leyendo.

Vamos a _Manage > Manage Configuration_. Como quiero que esta personalización esté para todo el mundo, el parámetro **Username** lo pongo a "All Users". En **Project Name** puedo elegir que se aplique a un sólo proyecto o a todos. Esto ya depende de cómo te lo quieras montar.

Por defecto los valores son:

{% highlight php %}
array ( selection, edit, priority, id, sponsorship_total, bugnotes_count, attachment, category_id, severity, status, last_updated, summary )
{% endhighlight %}

Y como quiero que haya una nueva columna con el tipo de navegador, en **Configuration Option** pones "view_issues_page_columns" y en **Value** esto:

{% highlight php %}
array ( selection, edit, priority, id, sponsorship_total, bugnotes_count, attachment, category_id, custom_Browser, severity, status, last_updated, summary )
{% endhighlight %}

Puedes encontrar más información sobre configuración de Mantis en su [manual online](http://docs.mantisbt.org/master/en/administration_guide.html).
