# Información
Este proyecto hace uso de la herramienta https://jekyllrb.com/ y está basado en el artículo http://jmcglone.com/guides/github-pages/

## Instalación

Podemos instalar el paquete desde el repositorio de Ubuntu:

```sh
$ apt install jekyll ruby-jekyll-paginate
```

También puedes usar Docker, con lo que te ahorras de instalar los paquetes.

## Uso

Una vez instalado lo ejecutamos con el parámetro **server** para hacer pruebas en local:

```sh
$ jekyll serve
```

En el caso de usar Docker, existe un Makefile que facilita el uso:

```sh
$ make serve
```

Una vez terminada la edición lo publicamos subiéndolo a Github:

```sh
$ git push
```

Pasados unos segundos la nueva entrada estará disponible en https://monkiki.github.io/

## Extra

- https://pages.github.com/versions/
