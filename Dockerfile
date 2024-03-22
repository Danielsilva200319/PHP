FROM php:8-fmp-buster

ARG Timezone

# Use the default production configuration
COPY ./php.ini /usr/local/etc/php/conf.d/docker-php-config.ini

# Install system dependencies
RUN apt-get update && apt-get install -y git unzip \
    && pecl install \
        apcu \
        xdebug \
        redis \
    && docker-php-ext-enable \
        apcu \
        xdebug \
        redis 
# Install PHP extensions Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install pdo pdo_mysql

# Get latest composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/conmposer

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${Timezone} /etc/localtime && echo ${Timezone} >