FROM php:7.4-alpine
MAINTAINER Gagan Deep Singh<me@gagan.pro>

# Allows PHPCS to process files in parallel
RUN docker-php-ext-configure pcntl
RUN docker-php-ext-install pcntl

# Install git to clone wpcs, we'll remove it later
RUN apk add --no-cache --virtual build-deps git

# Lets install phpcs and make it executable
RUN curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs
RUN chmod +x /usr/local/bin/phpcs

# Now intalling wpcs and VIP standards and setting phpcs config to wpcs path
RUN mkdir /wpcs
RUN git clone -b master --depth=1 https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /tmp/WordPress-Coding-Standards && \
	mv /tmp/WordPress-Coding-Standards/WordPress* /wpcs/
RUN git clone -b 2.10 --depth=1 https://github.com/sirbrillig/phpcs-variable-analysis.git /tmp/phpcs-variable-analysis && \
	mv /tmp/phpcs-variable-analysis/VariableAnalysis /wpcs/
RUN git clone -b master --depth=1 https://github.com/Automattic/VIP-Coding-Standards.git /tmp/VIP-Coding-Standards && \
	mv /tmp/VIP-Coding-Standards/WordPress* /wpcs/
RUN git clone -b master --depth=1 https://github.com/PHPCompatibility/PHPCompatibility.git /tmp/PHPCompatibility && \
	mv /tmp/PHPCompatibility/PHPCompatibility /wpcs/ && mv /tmp/PHPCompatibility/PHPCSAliases.php /wpcs/PHPCSAliases.php
RUN git clone -b master --depth=1 https://github.com/PHPCompatibility/PHPCompatibilityParagonie.git /tmp/PHPCompatibilityParagonie && \
	mv /tmp/PHPCompatibilityParagonie/PHPCompatibility* /wpcs/
RUN git clone -b master --depth=1 https://github.com/PHPCompatibility/PHPCompatibilityWP.git /tmp/PHPCompatibilityWP && \
	mv /tmp/PHPCompatibilityWP/PHPCompatibility* /wpcs/
RUN rm -rf /tmp/*
RUN phpcs --config-set installed_paths /wpcs

# Remove the build dependencies to keep image small
RUN apk del --no-cache build-deps

# Remove PHP Source files
RUN rm -rf /usr/src/

# Set our entrypoint
ENTRYPOINT ["docker-php-entrypoint"]