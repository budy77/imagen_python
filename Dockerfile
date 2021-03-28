FROM ubuntu

##deshabilitar el modo interactivo para que las instalaciones no nos ppregunten nada
#ENV DEBIAN_FRONTEND noninteractive
#ENV DEBCONF_NONINTERACTIVE_SEEN true

#seteo de la zona horaria del sistema
ENV TZ=America/La_Paz
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#RUN apt-get update
#RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y python3.8

RUN echo 1.0 >> /etc/version && apt-get install -y git \ 
    && apt-get install -y iputils-ping

RUN mkdir /datos
WORKDIR /datos
RUN touch f1.txt

RUN mkdir /datos2
WORKDIR /datos2
RUN touch f2.txt

#copy al ultimo workdir datos2
COPY dirprueba ./dirprueba
#copy a la ruta datos
COPY dirprueba /datos/dirprueba

#para copiar tambien se puede usar el ADD
ADD dirprueba ./dirprueba2

#ENV
ENV dir=/directoriouno dir1=/directoriodos
RUN mkdir $dir

#ARG permite enviar una variable al momento de generar la imagen
#ARG name

#expose
#instalamos apache
RUN apt-get update && apt-get install -y apache2
EXPOSE 80

#volume creara un volumen anonimo dentro de docker para la persistencia el cual puede ser usado por otro contenedor
ADD pagina /var/www/html
VOLUME [ "/var/www/html" ]


#arrancamos apache
ADD startapache.sh .
CMD ./startapache.sh

#CMD [ "/bin/bash" ]
#ENTRYPOINT [ "/bin/bash" ]