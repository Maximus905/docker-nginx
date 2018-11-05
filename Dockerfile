FROM nginx:1.15.5

# install tools
RUN apt-get update && apt-get install --no-install-recommends -y procps htop \
    && apt-get purge -y --auto-remove \
    && rm -r /var/lib/apt/lists/*
ENV NGINX_CONF /etc/nginx/nginx.conf
#for using with php-fpm
ENV USER_UID 33
ENV USER_NAME www-data
ENV GROUP_UID 33
ENV GROUP_NAME www-data
# to use socket don't forget set in site conf file path to socket:
# i.e. fastcgi_pass: unix:/var/run/php-fpm.sock;

COPY conf/nginx.conf $NGINX_CONF
COPY conf/nginx.d/default.conf /etc/nginx/nginx.d/
COPY create_user /usr/local/bin/
RUN chmod u+x /usr/local/bin/create_user

#RUN create_user

RUN mkdir -p /etc/nginx/sites-enabled \
 && mkdir -p /var/www
ENTRYPOINT ["create_user"]
WORKDIR /var/www
CMD ["nginx", "-g", "daemon off;"]