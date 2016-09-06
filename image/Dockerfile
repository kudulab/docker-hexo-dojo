# From the just built image which has ide configs already installed.
FROM hexoide_configs:temp

# For Hexo blog
RUN apk add --no-cache nano rsync && npm install hexo-cli -g &&\
  npm install hexo-deployer-rsync --save
