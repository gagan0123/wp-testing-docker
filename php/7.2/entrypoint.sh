#!/bin/bash
set -e

# Provide github token if you are using composer a lot in non-interactive mode
# Otherwise one day it will get stuck with request for authorization
# https://github.com/settings/tokens
if [[ ! -z "$COMPOSER_GITHUB" ]]
then
    composer config --global github-oauth.github.com "$COMPOSER_GITHUB"
fi

if [ $# -eq 0 ]; then
    docker-php-entrypoint -a
else
    docker-php-entrypoint "$@"
fi