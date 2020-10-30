FROM php:8.0.0RC3-alpine
MAINTAINER Gagan Deep Singh<me@gagan.pro>

# Required packages for executing bash scripts and svn commands
RUN apk add --no-cache bash subversion

# Install PHP dependencies for extensions
# For bz2 : bzip2 bzip2-dev
# For gd : libpng libpng-dev libjpeg-turbo libjpeg-turbo-dev freetype freetype-dev libgd 
# For intl(don't remove dev): icu-dev
# For zip: libzip libzip-dev
# For ImageMagick: imagemagick imagemagick-dev
RUN apk add --no-cache \
    bzip2 \
    bzip2-dev \
    libpng \
    libpng-dev \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    freetype \
    freetype-dev \
    libgd \
    icu-dev \
    libzip \
    libzip-dev

# Configure PHP Extensions
RUN docker-php-ext-configure bz2
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure mysqli
RUN docker-php-ext-configure pcntl
RUN docker-php-ext-configure zip

# Install php extensions
RUN docker-php-ext-install \
    bz2 \
    gd \
    intl \
    mysqli \
    pcntl \
    zip

# Now getting things done with pecl
RUN apk add --no-cache pcre-dev ${PHPIZE_DEPS}

# Can't use PECL directly, so downloading custom extensions manually

# Download source for xdebug to be installed later
RUN mkdir -p /usr/src/php/ext/xdebug && curl -fsSL https://pecl.php.net/get/xdebug | tar xvz -C "/usr/src/php/ext/xdebug" --strip 1

# Download source for redis to be installed later
RUN mkdir -p /usr/src/php/ext/redis && curl -fsSL https://pecl.php.net/get/redis | tar xvz -C "/usr/src/php/ext/redis" --strip 1

# Imagick and MongoDB are not yet available for PHP 8, so skipping them

# Installing custom pecl extensions
RUN docker-php-ext-install \
    xdebug \
    redis

# Remove pecl related stuff
RUN apk del --no-cache pcre-dev ${PHPIZE_DEPS}

# Remove unnecessary files
RUN apk del --no-cache \
    bzip2-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    imagemagick-dev

# Remove PHP Source files
RUN rm -rf /usr/src/

# Install PHPUnit and make it executable
RUN curl -L https://phar.phpunit.de/phpunit-7.phar -o /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit

# Install wp-cli
RUN curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
    -o /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

# Additional Softwares for extended tags
# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Install NodeJS, NPM and Yarn
RUN apk add --no-cache nodejs npm yarn

# Copy and set our entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]