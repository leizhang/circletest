FROM php:7.0-fpm

ENV ENV_VAR=dev

WORKDIR /var/www/html
COPY . ./