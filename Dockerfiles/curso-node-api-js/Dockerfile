# Usa una imagen base de Node.js
FROM node:18

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el package.json y package-lock.json al directorio de trabajo
#COPY package*.json ./

# Copia el resto de los archivos de la aplicación al directorio de trabajo
COPY . .

# Instala las dependencias de la aplicación
RUN npm install


# Expone el puerto en el que tu aplicación se ejecuta (por ejemplo, 3000)
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["npm", "start"]
