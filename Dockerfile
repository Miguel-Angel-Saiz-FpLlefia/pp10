FROM php:8.2-apache

# Install PostgreSQL client libraries
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache Rewrite Module
RUN a2enmod rewrite

# Set the working directory to the web root
WORKDIR /var/www/html

# Copy all files from the local directory to the container
# We copy src content to the root for easier hosting or keep it as is
COPY src/ .
COPY database.sql ../database.sql

# Set correct permissions for Apache
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80
