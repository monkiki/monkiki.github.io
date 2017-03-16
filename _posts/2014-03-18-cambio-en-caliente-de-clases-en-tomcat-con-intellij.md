---
author: monkiki
comments: true
date: 2014-03-18 09:33:35+00:00
layout: post
link: https://monkiki.wordpress.com/2014/03/18/cambio-en-caliente-de-clases-en-tomcat-con-intellij/
slug: cambio-en-caliente-de-clases-en-tomcat-con-intellij
title: Cambio en caliente de clases en Tomcat con IntelliJ
wordpress_id: 233
categories:
- Java
tags:
- DCEVM
- IntelliJ
- JRebel
---

De acuerdo con [su página](http://ssw.jku.at/dcevm/), la DCEVM (Dynamic Code Evolution Virtual Machine - Máquina Virtual de Evolución de Código Dinámico) es una modificación de máquina virtual de Java HotSpot (TM) que permite cambios de las clases cargadas en tiempo de ejecución. Las máquina virtual que solemos usar permite cambios en el cuerpo de los métodos, pero no añadir nuevos métodos o cambiar la definición de los mismos.

Cuando estás desarrollando es bastante habitual que tengas que cambiar la implementación de una clase, y muchas veces ese cambio hace que debas parar el servidor de aplicaciones y arrancarlo de nuevo para que los cambios surtan efectos. Dependiendo de la complejidad de la aplicación, estos tiempos de parada e inicio pueden ser relativamente largos y aburridos. Gracias a DCEVM el esperar se va a acabar :)

Sé que existe otros métodos para conseguir este mismo objetivo, como JRebel que funciona bastante bien. De hecho se publicita argumentando que estos tiempos de reinicio cuestan dinero a la empresa que mediante su solución ahorra dinero. No tengo nada en contra de JRebel, pero DCEVM funciona realmente bien y además es gratis :P

Desde hace unos meses uso IntelliJ, de modo que explicaré cómo configurarlo para usar esta máquina virtual alternativa. Vamos a **File** > **Settings** > **Plugins**, clickamos en **Browse repositories** y buscamos "DCEVM integration". Una vez instalado debemos reiniciar el IDE. Al iniciar IntelliJ nos mostrará un mensaje "_DCEVM is avaiblable fro your environment: Would you like to download it?_" para decirnos que existe una versión disponible de DCEVM y si la queremos bajar. Obviamente, si que queremos.

Una vez bajada, vamos a la configuración de Tomcat (**Edit Configuration...**) y en la solapa **Startup/Connection** seleccionados **Debug** y añadimos la variable **JAVA_HOME** con la ubicación local de DCEVM. En la solapa **Server** seleccionamos **Update classes and resources** para la opción **On frame deactivation**.

Ahora cuando arranques Tomcat en modo debug podrás hacer las modificaciones que quieras sin tener que reinciarlo.
