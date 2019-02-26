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

# Travis fold functions
fold_start() {
  echo -e "travis_fold:start:$1\033[33;1m$2\033[0m"
}

fold_end() {
  echo -e "\ntravis_fold:end:$1\r"
}

# Looping through tags and releasing each tag
for TAG in ${CONTAINERS[*]}
do
    # Defining variables
    export CONTAINER_TEST_IMAGE="$DEV_REPO:$TAG-$TRAVIS_COMMIT";
    export CONTAINER_RELEASE_IMAGE="$RELEASE_REPO:$TAG";

    fold_start "$TAG" "Releasing tag $TAG from $CONTAINER_TEST_IMAGE to $CONTAINER_RELEASE_IMAGE"
    # Releasing current image
    docker pull $CONTAINER_TEST_IMAGE;
    docker tag $CONTAINER_TEST_IMAGE $CONTAINER_RELEASE_IMAGE;
    docker push $CONTAINER_RELEASE_IMAGE
    fold_end "$TAG"
done