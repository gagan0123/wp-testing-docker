FROM php:7.0-alpine
MAINTAINER Gagan Deep Singh<me@gagan.pro>

# Required packages for executing bash scripts and svn commands
RUN apk add --no-cache bash subversion

# Install PHP dependencies
RUN apk add --no-cache \
    # For bz2 extension
    bzip2 \
    bzip2-dev \
    # For gd extension
    libpng \
    libpng-dev \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    freetype \
    freetype-dev \
    libgd \
    # For intl(don't remove dev)
    icu-dev \
    # For zip
    libzip \
    libzip-dev

# Configure PHP Extensions
RUN docker-php-ext-configure bz2
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure mysqli
RUN docker-php-ext-configure zip

# Install php extensions
RUN docker-php-ext-install \
    bz2 \
    gd \
    intl \
    mysqli \
    zip

# Remove unnecessary files
RUN apk del --no-cache \
    bzip2-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Install PHPUnit and make it executable
RUN curl -L https://phar.phpunit.de/phpunit-6.phar -o /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit

# Copy and set our entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]