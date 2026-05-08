FROM php:8.2-apache-bookworm

# Actualizamos e instalamos librerías necesarias con un fix para mirrors inestables
RUN apt-get update --fix-missing && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Habilitar el módulo Rewrite de Apache
RUN a2enmod rewrite

# Directorio de trabajo
WORKDIR /var/www/html

# Copiamos el contenido de src a la raíz del servidor
COPY src/ .
# Copiamos el SQL un nivel por encima para que install.php lo encuentre
COPY database.sql ../database.sql

# Permisos para Apache
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
