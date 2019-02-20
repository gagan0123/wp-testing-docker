FROM alpine
MAINTAINER Gagan Deep Singh<me@gagan.pro>

# Update APK sources
RUN apk update

# Upgrade existing packages
RUN apk upgrade

# Install bash subversion git and wget
RUN apk --no-cache add bash subversion git wget

# Clean up our build
RUN rm -rf /var/cache/apk/*