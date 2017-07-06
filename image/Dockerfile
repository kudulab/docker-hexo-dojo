# From the just built image which has ide configs already installed.
FROM docker-registry.ai-traders.com/hexoide:temp

# temporary only, used below
COPY package.json /ide/work/

# For Hexo blog
# * `chown ide:ide -R /ide/work` or else: "npm WARN checkPermissions Missing
#  write access to /ide/work"
# * generate node_modules with current dir /ide/work, because when I tried symlinking
#  `ln -s /home/ide/node_modules /ide/work/node_modules` I got on `npm install`:
#  "error Maximum call stack size exceeded".
RUN apk add --no-cache nano rsync
RUN apk add --no-cache autoconf &&\
  chown ide:ide -R /ide/work &&\
  sudo -E -H -u ide /bin/bash -lc "cd /ide/work/ && npm install" &&\
  mv /ide/work/node_modules /home/ide/node_modules &&\
  chown ide:ide -R /home/ide/node_modules
