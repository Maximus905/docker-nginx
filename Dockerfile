FROM nginx

# install tools
RUN apt-get update && apt-get install -y procps htop \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -r /var/lib/apt/lists/*

ENV nginx_user_UID 3000
ENV nginx_user_NAME www-user
ENV nginx_group_UID 3000
ENV nginx_group_NAME www-user

RUN set -ex \
 && addgroup --system --gid ${nginx_group_UID} ${nginx_group_NAME} \
 && adduser --uid ${nginx_user_UID} --system --gid ${nginx_group_UID} ${nginx_user_NAME}
