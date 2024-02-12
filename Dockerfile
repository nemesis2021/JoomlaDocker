# Use an official PHP with Apache image as the base
FROM php:7.4-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libzip-dev \
        unzip \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd mysqli zip

# Download and extract Joomla
WORKDIR /var/www/html
RUN curl -o joomla.zip -SL https://downloads.joomla.org/cms/joomla3/3-10-4/Joomla_3-10-4-Stable-Full_Package.zip \
        && unzip joomla.zip \
        && rm joomla.zip \
        && chown -R www-data:www-data .

# Copy Apache configuration
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set environment variables
ENV JOOMLA_DB_HOST=localhost \
    JOOMLA_DB_USER=root \
    JOOMLA_DB_PASSWORD=password \
    JOOMLA_DB_NAME=joomla

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
