#!/usr/bin/env bash

# Circle currently using old version of docker which still uses the now deprecated email option
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS $DOCKER_REGISTRY
docker tag merrettr/circletest $DOCKER_REPOSITORY
docker push $DOCKER_REPOSITORY
echo 'copying docker-compose file'
scp ./docker-compose-prod.yml $DEPLOY_USER@$DEPLOY_HOST:./docker-compose.yml
echo 'setting docker credentials'
ssh $DEPLOY_USER@$DEPLOY_HOST "docker login -u  $DOCKER_USER  -p  $DOCKER_PASS"
echo 'pulling images'
ssh $DEPLOY_USER@$DEPLOY_HOST "docker pull $DOCKER_REPOSITORY"
echo 'upping compose'
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker-compose up -d'
