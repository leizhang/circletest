#!/usr/bin/env bash

set -e

# Circle currently using old version of docker which still uses the now deprecated email option
echo 'logging in to docker locally'
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS $DOCKER_REGISTRY
echo 'tagging image'
docker tag merrettr/circletest-app $DOCKER_REGISTRY/merrettr/circletest-app
docker tag merrettr/circletest-http $DOCKER_REGISTRY/merrettr/circletest-http
echo 'pushing image'
docker push $DOCKER_REGISTRY/merrettr/circletest-app
docker push $DOCKER_REGISTRY/merrettr/circletest-http
echo 'copying docker-compose file'
scp ./docker-compose-prod.yml $DEPLOY_USER@$DEPLOY_HOST:./docker-compose.yml
echo 'logging in to docker remotely'
ssh $DEPLOY_USER@$DEPLOY_HOST "docker login -u  $DOCKER_USER  -p  $DOCKER_PASS $DOCKER_REGISTRY"
echo 'pulling images'
ssh $DEPLOY_USER@$DEPLOY_HOST "docker pull $DOCKER_REGISTRY/merrettr/circletest-app"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker pull $DOCKER_REGISTRY/merrettr/circletest-http"
echo 'upping compose'
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker-compose up -d'