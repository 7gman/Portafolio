# Usa una imagen base de Ubuntu
FROM ubuntu:latest

# Actualiza los paquetes y instala OpenSSH
RUN apt-get update && \
    apt-get install -y openssh-server

# Crea el directorio para el servidor SSH
RUN mkdir /var/run/sshd

# Configura la contraseña de root para SSH
RUN echo 'root:root' | chpasswd

# Expone el puerto 22
EXPOSE 22

# Comando para iniciar el servicio SSH
CMD ["/usr/sbin/sshd", "-D"]
