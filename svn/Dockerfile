FROM alpine
MAINTAINER Gagan Deep Singh<me@gagan.pro>

# Update APK sources
RUN apk update --no-cache

# Upgrade existing packages
RUN apk upgrade --no-cache

# Install bash subversion git and wget
RUN apk --no-cache add bash subversion git curl wget openssh-client rsync

# Clean up our build
RUN rm -rf /var/cache/apk/*
