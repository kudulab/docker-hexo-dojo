# From the just built image which has ide configs already installed.
FROM hexoide_configs:temp

# For Hexo blog
RUN apk add --no-cache nano rsync && npm install hexo-cli -g &&\
  npm install hexo-deployer-rsync --save &&\
  npm install hexo-html-minifier --save &&\
  npm install hexo-clean-css --save &&\
  npm install hexo-uglify --save &&\
  npm install hexo-generator-category --save &&\
  npm install hexo-generator-index --save &&\
  npm install hexo-generator-archive --save &&\
  npm install hexo-generator-tag --save
