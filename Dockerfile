# Usamos una imagen de PHP 8.2 con FPM (FastCGI Process Manager)
FROM php:8.2-fpm

# Mantenedor del contenedor
LABEL maintainer="Brady Wetherington <bwetherington@grokability.com>"

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    nginx \
    zip \
    unzip \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libldap2-dev \
    mariadb-client \
    supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql bcmath zip mbstring xml ldap opcache

# Copiar archivos del proyecto al contenedor
WORKDIR /var/www/html
COPY . .

# Cambiar permisos para almacenamiento
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exponer el puerto correcto para PHP-FPM
EXPOSE 9000

# Definir el comando de inicio del contenedor
CMD ["php-fpm"]
