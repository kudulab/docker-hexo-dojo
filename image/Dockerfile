# From the just built image which has ide configs already installed.
FROM hexoide_configs:temp

COPY package.json /home/ide/node/

# For Hexo blog
RUN apk add --no-cache nano rsync &&\
  chown ide:ide -R /home/ide/node &&\
  npm install hexo-cli -g &&\
  sudo -E -H -u ide /bin/bash -lc "cd /home/ide/node/ && npm install --save-exact"
