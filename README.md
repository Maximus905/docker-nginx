# NGINX
### based on official nginx image: nginx:1.15.5 (plus some tools like ps and htop.)
#### How to use:
* create docker-compose.yml file like this:
```
version: '3'
services:
  nginx:
    image: maximus905/nginx
    ports:
      - "8080:80"
    volumes:
      - ./www:/var/www
      - ./conf/nginx/sites-enabled:/etc/nginx/sites-enabled
```
where ./www - folder with your site or sites
and  ./conf/nginx/sites-enabled - folder with sites configs
* run 
```
docker-compose up
```

#### if you want to change user in nginx.conf:
By default user in nginx.conf is set as www-data.
If you want to change these settings, you should change values for next env variables: 
* USER_UID 33
* USER_NAME www-data
* GROUP_UID 33
* GROUP_NAME www-data
after that DON'T FORGET to mount customized nginx.conf with new user and group (path for mounting: /etc/nginx/nginx.conf)
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

