---
author: monkiki
comments: true
date: 2010-01-29 16:54:58+00:00
layout: post
link: https://monkiki.wordpress.com/2010/01/29/backup-automaticos-con-rsync/
slug: backup-automaticos-con-rsync
title: Backup automáticos con rsync
wordpress_id: 81
categories:
- Ubuntu
---

¿Quién no ha perdido alguna vez documentos o fotos por no tener un backup? Las copias de seguridad no se echan en falta hasta que se necesitan. Y por mucho que te digan, hasta que no pasa una catástrofe no te las tomas en serio.

Cuando te dedicas a la administración de sistemas las copias de seguridad es algo a tener muy presente. No le puedes decir a un cliente que has perdido todo sus datos y seguir durmiendo por las noches. En este caso siempre se suele recurrir al demonio cron a quien no se le pasa una.

En el caso de un ordenador de casa la cosa cambia porque no suele estar encendido siempre. Y tampoco es aconsejable por el bien de la capa de ozono :) De modo que hay que enfocar el problema desde otro punto de vista.

Yo, por ejemplo, tengo dos discos duros así que uso el segundo (más pequeño, por cierto) para copias de seguridad de ciertos directorios que me interesan. Como no quiero perder nada, quiero que se ejecute el script de backup al apagar la máquina.

Para empezar creo un fichero que será el encargado de tan magna tarea:

{% highlight bash %}
$ sudo vim /etc/init.d/backup.sh
{% endhighlight %}

El cual contendrá algo así como esto:

{% highlight bash%}
#! /bin/sh
PATH=/sbin:/usr/sbin:/bin:/usr/bin

case "$1" in
  start)
    # No-op
    ;;
  stop)
    rsync -apzhHR --delete --exclude=*~ --delete-excluded <src> <dst>
    ;;
  *)
    echo "Usage: $0 stop" >&2
    exit 3
    ;;
esac
{% endhighlight %}

*Nótese que el proceso de backup se ejecuta en la acción **stop**, o sea, cuando se apaga la máquina. Si quisiéramos ejecutarla al iniciarla tendría que hacerse en la acción **start**.*

Por supuesto hay que hacerlo ejecutable:

{% highlight bash %}
$ sudo chmod +x /etc/init.d/backup.sh
{% endhighlight %}

Y lo registramos para que se ejecute en los runlevel por defecto:

{% highlight bash %}
$ sudo update-rc.d backup.sh defaults
{% endhighlight %}

Aquí van algunos enlaces interesantes sobre rsync:

  * [Easy Automated Snapshot-Style Backups with Linux and Rsync](http://www.mikerubel.org/computers/rsync_snapshots/)
  * [Backups con rsync](http://www.vicente-navarro.com/blog/2008/01/13/backups-con-rsync/)
  * [rsync notes](http://soniahamilton.wordpress.com/2006/05/14/rsync-notes/)
  * [Backups using rsync](http://www.sanitarium.net/golug/rsync_backups.html)
