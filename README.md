[![Build Status](https://travis-ci.com/gagan0123/wp-testing-docker.svg?branch=master)](https://travis-ci.com/gagan0123/wp-testing-docker)

# WordPress PHP CI Kit with Docker

This repository contains a set of utilities for running PHP tests for WordPress
plugins and themes via [Gitlab CI](https://about.gitlab.com/gitlab-ci/).

These images are based on official Docker PHP images built upon Alpine Linux with
additional modules needed for testing with WordPress.

The goal of these tools is to automate as much as possible of routine work related
to configuring the runner so you can concentrate on writing tests for your code.

## Tags:

### Main Tags wpunit/php:(7.3, 7.2, 7.1, 7.0 and 5.6)
These tags contain respective PHP Versions, compiled with bz2, gd, intl, mysqli
and zip extensions for better compatibility with WordPress related testing.

Special case is 5.6, which contains additional mysql extension(original, DEPRECATED),
for testing with some lower versions of WordPress.

### Additional Softwares in the main tags:
1. [PHPUnit](https://phpunit.de/)
1. [WP-CLI](https://wp-cli.org/)

### Extended Tags wpunit/php:(7.3, 7.2, 7.1, 7.0 and 5.6)-extended
Apart from the extensions and softwares mentioned above, these tags contain additional
extensions namely Xdebug, Imagick, MongoDB, and Redis, which are installed from PECL.

### Additional Softwares in extended tags:
1. [NodeJS](https://nodejs.org/)
1. [NPM](https://www.npmjs.com/)
1. [Yarn](https://yarnpkg.com/)
1. [Composer](https://getcomposer.org/)

## Special tags:

### WPCS wpunit/php:wpcs
It has WordPress Coding Standards added and configured, running with PHP 7.2 on Alpine.
We're using it as a separate image as PHPCS is first run to verify the code and
only after that PHPUnit is run. So no point in including PHPCS with WPCS rules in main images.

### SVN Release wpunit/php:svn-release
This image is for automated release of plugins/themes to WordPress.org


## Example Gitlab config

You can go through a sample gitlab configuration for a
[WordPress plugin here](https://gitlab.com/gagan0123/barebone-plugin/).  
Make sure to include both, the gitlab configuration file .gitlab-ci.yml,
.phpcs.xml.dist, phpunit.xml.dist, tests folder and the bin folder with install-wp-tests.sh