---
author: monkiki
comments: true
date: 2010-05-07 07:34:06+00:00
layout: post
link: https://monkiki.wordpress.com/2010/05/07/crear-un-repositorio-de-maven/
slug: crear-un-repositorio-de-maven
title: Crear un repositorio de Maven
wordpress_id: 160
categories:
- Java
- Ubuntu
---

Desde que uso Maven evito, siempre que puedo, incluir los jar de las dependencias en el proyecto. Un buen sitio donde localizar estas dependencias es [http://mvnrepository.com/](http://mvnrepository.com/). A veces un proyecto mantiene su propio repositorio de Maven, como es el caso de JBoss, y tienes que registrarlo en el pom.xml:

{% highlight xml %}
<repository>
  <id>jboss.com</id>
  <name>JBoss Maven Repository</name>
  <url>http://repository.jboss.com/maven2</url>
</repository>
{% endhighlight %}

Pero no siempre pueden encontrar las librerías que necesitas en un repositorio de Maven. En en ese caso puede optar por incluirlas en el fuente de la aplicación y registrarlas manualmente:

{% highlight bash %}
$ mvn install:install-file -DgroupId=entagged.audioformats -DartifactId=audioformats -Dversion=0.15 -Dpackaging=jar -Dfile=entagged-audioformats-0.15.jar
{% endhighlight %}

O puedes crear tu propio repositorio. En este caso hay distintas herramientas que te ayudarán en la tarea, como [Nexus](http://nexus.sonatype.org/). Pero si eres amante de las cosas sencillas te gustará saber que con un simple servidor web también puedes hacerlo.

Para empezar creamos un usuario al que llamaremos "maven" y en su $HOME también vamos a crear los directorio "repository" y "repository/maven2". Le tendremos que dar los permisos de lectura pertienentes a Apache porque se encargará de servir las librerías. Por tanto daremos de alta un VirtualHost para tener acceso al repositorio:

{% highlight xml %}
<VirtualHost *>
  DocumentRoot /home/maven/repository
  ServerName repository.monkiki.org
</VirtualHost>
{% endhighlight %}

Mientra, en nuestro ordenador local hay que editar el fichero ~/.m2/settings.xml para establecer las credenciales que nos permitirán registrar librerías en el repositorio que acabamos de crear.

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<settings>
  <localRepository>/home/monkiki/.m2/repository</localRepository>
  <servers>
    <server>
      <id>monkiki.org</id>
      <username>maven</username>
      <password>s3cr3t0</password>
    </server>
  </servers>
</settings>
{% endhighlight %}

Podemos ir incluyendo librerías así:

{% highlight bash %}
$ mvn deploy:deploy-file -DgroupId=entagged.audioformats -DartifactId=audioformats -Dversion=0.15 -Dpackaging=jar \
   -Dfile=entagged-audioformats-0.15.jar -Durl=scp://repository.monkiki.org/home/maven/repository/maven2 \
   -DrepositoryId=org.monkiki
{% endhighlight %}

En caso de que la librería tenga dependencias, es buena praxis indicar en el registro el pom de dicha librería para que Maven gestione correctamente estas dependencias transitivas, en lugar de tener que incluirlas artificialmente en el pom.xml de nuestro proyecto. Para ello se utiliza el parámetro:

{% highlight java %}
﻿-DpomFile=/path/to/pom.xml
{% endhighlight %}

En los pom.xml de nuestros proyectos, hemos de registrar repositorio de esta manera:

{% highlight xml %}
<repositories>
  <repository>
    <id>monkiki.org</id>
    <name>Mi repositorio de maven particular</name>
    <url>http://repository.monkiki.org/maven2</url>
  </repository>
</repositories>
{% endhighlight %}

Y esto es todo, amigos!

Ver también:

  * [Creación de un repositorio maven interno accesible por SSH](http://www.adictosaltrabajo.com/tutoriales/repositoriomaven.php)
  * [Maven Deploy Plugin](http://maven.apache.org/plugins/maven-deploy-plugin/usage.html)
