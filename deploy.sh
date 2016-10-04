#!/usr/bin/env bash

echo "copying docker-compose file"
scp ./docker-compose.yml $DEPLOY_USER@$DEPLOY_HOST:./docker-compose.yml

echo "setting docker credentials"
ssh $DEPLOY_USER@$DEPLOY_HOST "docker login -u  $DOCKER_USER  -p  $DOCKER_PASS"

echo "pulling images"
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker-compose pull'


echo 'upping compose'
ssh $DEPLOY_USER@$DEPLOY_HOST 'docker-compose up -d'

echo 'done'

exit 0