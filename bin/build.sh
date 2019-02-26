#! /bin/bash

# Defining variables
export CONTAINER_TEST_IMAGE="$DEV_REPO:$TAG-$TRAVIS_COMMIT"
export CONTAINER_RELEASE_IMAGE="$RELEASE_REPO:$TAG"

# Change directory to our Dockerfile
cd $FOLDER

# Login to docker
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Build Docker image using cache
docker pull $CONTAINER_RELEASE_IMAGE
docker build --cache-from $CONTAINER_RELEASE_IMAGE -t $CONTAINER_TEST_IMAGE .

# Push built image to docker
docker push $CONTAINER_TEST_IMAGE