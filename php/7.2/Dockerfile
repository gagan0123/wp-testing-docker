FROM php:7.2-alpine
MAINTAINER Gagan Deep Singh<me@gagan.pro>

# Required packages for executing bash scripts and svn commands
RUN apk add --no-cache bash subversion

# Install PHP dependencies for extensions
# For bz2 : bzip2 bzip2-dev
# For gd : libpng libpng-dev libjpeg-turbo libjpeg-turbo-dev freetype freetype-dev libgd 
# For intl(don't remove dev): icu-dev
# For zip: libzip libzip-dev
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
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
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

# Remove unnecessary files
RUN apk del --no-cache \
    bzip2-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev

# Remove PHP Source files
RUN rm -rf /usr/src/

# Install PHPUnit and make it executable
RUN curl -L https://phar.phpunit.de/phpunit-7.phar -o /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit

# Install wp-cli
RUN curl -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
    -o /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

# Copy and set our entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]