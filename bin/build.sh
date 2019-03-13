#! /bin/bash

# Defining variables
export CONTAINER_TEST_IMAGE="$DEV_REPO:$TAG-$TRAVIS_COMMIT"
export CONTAINER_RELEASE_IMAGE="$RELEASE_REPO:$TAG"

# Travis fold functions
fold_start() {
  echo -e "travis_fold:start:$1\033[33;1m$2\033[0m"
}

fold_end() {
  echo -e "\ntravis_fold:end:$1\r"
}

# Change directory to our Dockerfile
cd $FOLDER

# Configure docker to use experimental feature to enable squash
fold_start "dockerconfigure" "Configuring docker"
echo '{"experimental":true}' | sudo tee /etc/docker/daemon.json
sudo service docker restart
fold_end "dockerconfigure"

# Login to docker
fold_start "dockerlogin" "Logging in to Docker"
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
fold_end "dockerlogin"

# Build Docker image using cache
fold_start "dockerpull" "Pulling from $CONTAINER_RELEASE_IMAGE"
docker pull $CONTAINER_RELEASE_IMAGE
fold_end "dockerpull"
fold_start "dockerbuild" "Building Image $CONTAINER_TEST_IMAGE"
docker build --squash --cache-from $CONTAINER_RELEASE_IMAGE -t $CONTAINER_TEST_IMAGE .
fold_end "dockerbuild"

# Push built image to docker
fold_start "dockerpush" "Pusing Image $CONTAINER_TEST_IMAGE"
docker push $CONTAINER_TEST_IMAGE
fold_end "dockerpush"