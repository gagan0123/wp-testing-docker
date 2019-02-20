# WordPress PHP CI Kit with Docker

This repository contains a set of utilities for running PHP tests in WordPress via [Gitlab CI](https://about.gitlab.com/gitlab-ci/).

## PHP Images:

1. PHP 5.6
1. PHP 7.0
1. PHP 7.1
1. PHP 7.2
1. PHP 7.3

These images are based on official Docker PHP images with additional modules.

The goal of these tools is to automate as much as possible of routine work related to configuring the runner so you can concentrate on writing tests for your code.

## Additional Packages

1. [PHPUnit](https://github.com/sebastianbergmann/phpunit)
1. [PHPCS](https://github.com/squizlabs/PHP_CodeSniffer)
1. [WPCS](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards)
1. [NodeJS](https://github.com/nodejs/node)
1. [Yarn](https://github.com/yarnpkg/yarn)
1. [Composer](https://github.com/composer/composer)
1. PHP Modules(bcmath bz2 calendar dba enchant exif zip bz2 ftp gd gettext gmp imap intl ldap mbstring mysqli opcache pcntl pdo pdo_dblib pdo_mysql pdo_pgsql pgsql pspell shmop snmp soap sockets sysvmsg sysvsem sysvshm tidy wddx xmlrpc xsl zip xdebug)

## Example Gitlab config

You can go through a sample gitlab configuration for a [WordPress plugin here](https://gitlab.com/gagan0123/barebone-plugin/).
Make sure to include both, the gitlab configuration file .gitlab-ci.yml, .phpcs.xml.dist, phpunit.xml.dist, tests folder and the bin folder with install-wp-tests.sh