# Usa la imagen base de Node.js
FROM node:18

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos package.json y package-lock.json para instalar dependencias
COPY package*.json ./

# Instala las dependencias de la aplicación
RUN npm install

# Copia el resto de los archivos de la aplicación al directorio de trabajo
COPY . .

# Expone el puerto en el que la aplicación escucha
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["npm", "start"]
