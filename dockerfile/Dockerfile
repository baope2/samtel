# Usar la imagen base de Nginx
FROM nginx:alpine

# Copiar el archivo index.html al directorio de Nginx
COPY . /usr/share/nginx/html/

# Exponer el puerto 80
EXPOSE 80

# Comando por defecto para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
