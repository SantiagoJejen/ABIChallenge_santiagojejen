#!/bin/bash -e


set -e

REPO_ROOT_DIR="$(git rev-parse --show-toplevel)"
# Generate Dockerfile for build.
cat "${REPO_ROOT_DIR}"/development/Dockerfile.development > "${REPO_ROOT_DIR}"/development/Dockerfile.build
cat "${REPO_ROOT_DIR}"/development/docker-compose.yml > "${REPO_ROOT_DIR}"/development/docker-compose-build.yml

DEFAULT_GO_IMAGE="golang:latest"

for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            IMAGE)                 IMAGE=${VALUE} ;;     
            *)   
    esac    

done

IMAGE=${IMAGE:-$DEFAULT_GO_IMAGE}
echo "IMAGE = $IMAGE"

APP_NAME=$(echo ${PWD##*/} | awk '{print tolower($0)}')
echo "APP_NAME = $APP_NAME"

sed -i -r "s/IMAGE/$IMAGE/" "${REPO_ROOT_DIR}"/development/Dockerfile.build
sed -i -r "s/IMAGE/$APP_NAME/" "${REPO_ROOT_DIR}"/development/docker-compose-build.yml

docker build -t $APP_NAME --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" -f "${REPO_ROOT_DIR}"/development/Dockerfile.build .
docker-compose -f ./development/docker-compose-build.yml up -d --build
rm "${REPO_ROOT_DIR}"/development/Dockerfile.build
echo "Environment succesfully mounted, now use VS CODE to edit inside your docker app..."
echo "Happy Hacking ☺️"
