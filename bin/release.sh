#! /bin/bash

# Creating array of tags to be pushed for release
CONTAINERS=(
    5.6
    5.6-extended
    7.0
    7.0-extended
    7.1
    7.1-extended
    7.2
    7.2-extended
    7.3
    7.3-extended
    wpcs
)

# Login to docker
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Looping through tags and releasing each tag
for TAG in ${CONTAINERS[*]}
do
    # Defining variables
    export CONTAINER_TEST_IMAGE="$DEV_REPO:$TAG-$TRAVIS_COMMIT";
    export CONTAINER_RELEASE_IMAGE="$RELEASE_REPO:$TAG";

    # Releasing current image
    docker pull $CONTAINER_TEST_IMAGE;
    docker tag $CONTAINER_TEST_IMAGE $CONTAINER_RELEASE_IMAGE;
    docker push $CONTAINER_RELEASE_IMAGE
done