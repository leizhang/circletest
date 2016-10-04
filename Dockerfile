FROM nginx:latest

COPY ./index.html /var/www/html/public/index.html
COPY ./default.conf /etc/nginx/conf.d/default.conf
