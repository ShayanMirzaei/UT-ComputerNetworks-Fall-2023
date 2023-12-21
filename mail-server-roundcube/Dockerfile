# Use the official Ubuntu 18.04 base image
FROM ubuntu:20.04

# Set non-interactive mode for package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    php-pgsql \
    php-intl \
    php-json \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip \
    unzip \
    wget \
    nano \
    telnet \
    iputils-ping \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*


# Install and configure Roundcube
WORKDIR /var/www/html
RUN wget https://github.com/roundcube/roundcubemail/releases/download/1.6.5/roundcubemail-1.6.5-complete.tar.gz && \
    tar xf roundcubemail-1.6.5-complete.tar.gz && \
    rm roundcubemail-1.6.5-complete.tar.gz && \
    mv roundcubemail-* roundcube && \
    chown -R www-data:www-data roundcube


# Create and configure Roundcube config file
COPY config.inc.php /var/www/html/roundcube/config/config.inc.php

COPY roundcube.conf /etc/apache2/sites-available/roundcube.conf
RUN ln -s /etc/apache2/sites-available/roundcube.conf /etc/apache2/sites-enabled/

# Expose ports HTTP
EXPOSE 80

# Start services
CMD service apache2 start && tail -f /var/log/apache2/error.log
