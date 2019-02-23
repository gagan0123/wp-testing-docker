FROM php:7.2-alpine
MAINTAINER Gagan Deep Singh<me@gagan.pro>

# Install git to clone wpcs, we'll remove it later
RUN apk add --no-cache --virtual build-deps git

# Lets install phpcs and make it executable
RUN curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs
RUN chmod +x /usr/local/bin/phpcs

# Now intalling wpcs and setting phpcs config to wpcs path
RUN git clone -b master --depth=1 https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git wpcs
RUN cd wpcs && rm -rf .gitattributes .phpcs.xml.dist .travis.yml CHANGELOG.md LICENSE README.md composer.json phpcs.xml.dist.sample phpunit.xml.dist .git .github .gitignore bin
RUN phpcs --config-set installed_paths /wpcs

# Remove the build dependencies to keep image small
RUN apk del --no-cache build-deps