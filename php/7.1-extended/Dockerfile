FROM php:7.1-alpine
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
    libzip-dev \
    imagemagick \
    imagemagick-dev

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

# Now getting things done with pecl
RUN apk add --no-cache pcre-dev ${PHPIZE_DEPS}
# Install Xdebug Imagick MongoDB and Redis
RUN pecl install \
    xdebug-2.7.0beta1 \
    imagick \
    mongodb \
    redis
# Remove pecl related stuff
RUN apk del --no-cache pcre-dev ${PHPIZE_DEPS}

# Enabling pecl extensions
RUN docker-php-ext-enable \
    xdebug \
    imagick \
    mongodb \
    redis

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