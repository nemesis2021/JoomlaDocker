# Use an official PHP with Apache image as the base
FROM php:7.4-apache

# Set environment variables
ENV JOOMLA_VERSION 3.9.28
ENV JOOMLA_SHA1 660dd87289f9d6168f2f2f94e6e6fb8a60e21632

# Download and install Joomla
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget; \
    wget -O joomla.tar.gz "https://downloads.joomla.org/cms/joomla3/${JOOMLA_VERSION}/Joomla_${JOOMLA_VERSION}-Stable-Full_Package.tar.gz"; \
    echo "$JOOMLA_SHA1 *joomla.tar.gz" | sha1sum -c -; \
    tar -xf joomla.tar.gz -C /var/www/html/; \
    chown -R www-data:www-data /var/www/html/; \
    rm -rf joomla.tar.gz; \
    apt-get purge -y --auto-remove wget; \
    rm -rf /var/lib/apt/lists/*

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
