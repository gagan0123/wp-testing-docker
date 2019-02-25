FROM php:7.3-alpine
MAINTAINER Gagan Deep Singh<me@gagan.pro>

RUN apk add --no-cache bash subversion

RUN apk add --no-cache --virtual phpDependencies \
    # For bz2 extension
    bzip2-dev \
    # For gd extension
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libgd \
    # For intl
    icu-dev \
    # For zip
    libzip-dev

RUN docker-php-ext-configure bz2
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure mysqli
RUN docker-php-ext-configure zip

RUN docker-php-ext-install \
    bz2 \
    gd \
    intl \
    mysqli \
    zip

# Get rid of extra files
RUN apk del --no-cache phpDependencies

# Install PHPUnit
RUN curl -L https://phar.phpunit.de/phpunit-7.phar -o /usr/local/bin/phpunit
RUN chmod +x /usr/local/bin/phpunit