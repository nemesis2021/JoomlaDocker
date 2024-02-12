# Use an official PHP with Apache image as the base
FROM php:7.4-apache

# Set environment variables
ENV JOOMLA_VERSION 3.9.28
ENV JOOMLA_SHA1 660dd87289f9d6168f2f2f94e6e6fb8a60e21632

RUN mkdir /html
WORKDIR /html
# Copy Joomla package into the container
COPY Joomla_3.9.28-Stable-Full_Package.tar.gz /joomla.tar.gz

# Extract Joomla package and install
RUN set -eux; \
    tar -xf /tmp/joomla.tar.gz -C /; \
    chown -R www-data:www-data /; \
    #rm -rf /tmp/joomla.tar.gz

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
