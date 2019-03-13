if [ $# -eq 0 ]; then
    docker-php-entrypoint -a
else
    docker-php-entrypoint "$@"
fi