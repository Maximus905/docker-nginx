FROM nginx:1.15.5

# install tools
RUN apt-get update && apt-get install -y procps htop \
    && apt-get purge -y --auto-remove \
    && rm -r /var/lib/apt/lists/*
#for using with php-fpm
ARG user_UID=3000
ARG user_NAME=www-user
ARG group_UID=3000
ARG group_NAME=www-user
# to use socket don't forget set in site conf file path to socket:
# fastcgi_pass: unix:/var/run/php-fpm.sock;

RUN set -ex \
 && addgroup --system --gid $group_UID $group_NAME \
 && adduser --uid $user_UID --system --gid $group_UID $user_NAME

RUN mkdir -p /etc/nginx/sites-enabled \
 && mkdir -p /var/www

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/nginx.d/

RUN sed -i -e "s/^user.*/user $user_NAME;/g" /etc/nginx/nginx.conf
WORKDIR /var/www