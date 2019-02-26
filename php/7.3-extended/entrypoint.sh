#!/bin/bash
set -e

# Provide github token if you are using composer a lot in non-interactive mode
# Otherwise one day it will get stuck with request for authorization
# https://github.com/settings/tokens
if [[ ! -z "$COMPOSER_GITHUB" ]]; then
    composer config --global github-oauth.github.com "$COMPOSER_GITHUB";
fi

# If specified we can switch the phpunit version
if [[ ! -z "$PHPUNIT_VERSION" ]]; then
    curl -L https://phar.phpunit.de/phpunit-$PHPUNIT_VERSION.phar -o /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit
fi

if [ $# -eq 0 ]; then
    docker-php-entrypoint -a
else
    docker-php-entrypoint "$@"
fi