# From the just built image which has ide configs already installed.
FROM hexoide_configs:temp

COPY package.json /ide/work/

# For Hexo blog
RUN apk add --no-cache nano rsync &&\
  sudo -E -H -u ide /bin/bash -lc "cd /ide/work/ && npm install" &&\
  mv /ide/work/node_modules /home/ide/node_modules &&\
  chown ide:ide -R /home/ide/node_modules
