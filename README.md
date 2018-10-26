# NGINX
### based on official nginx image: nginx:1.15.5 (plu some tools like ps and htop.)
During start container are created user and group according env variables with next default values:
* USER_UID 33
* USER_NAME www-data
* GROUP_UID 33
* GROUP_NAME www-data
after that these user and group are set in nginx.conf (path: /etc/nginx/nginx.conf)
To change user or group parametrs pass these variables to container like this:
``` 
docker container run --rm -d -e USER_NAME=www-user -e USER_UID=3000 maximus905/php-fpm
```

You can import your own nginx.conf and site configs via docker-compose file like this:
```
version: '3'
services:
  nginx:
    image: maximus905/nginx
    ports:
      - "8080:80"
    volumes:
      - ./www:/var/www
      - ./conf/nginx/nginx.conf:/etc/nginx/nginx.conf
      - ./conf/nginx/sites-enabled:/etc/nginx/conf.d
```
where ./conf/nginx/nginx.conf - your customized conf file
and  ./conf/nginx/sites-enabled - folder with sites configs

