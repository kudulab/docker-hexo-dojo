### 0.1.6 (2017-Dec-15)

* fix task: build, get docker image version from changelog to allow reproducible
 builds

### 0.1.5 (2017-Dec-14)

* use `docker-registry.ai-traders.com/node-ide:0.1.5` as base image #12143

### 0.1.4 (2017-Jul-06)

* do not use ruby for development; use releaser and docker-ops instead
* `hexo --version` and similar commands are now directly invocable by ide user
* fixed to not copy node_modules directory if it exists #10698

### 0.1.3 (20 Feb 2017)

* ensure the `node_modules` directory is owned by ide
* add more verbosity around the `node_modules` directory

### 0.1.2 (8 Sep 2016)

* copy the `node_modules` directory instead of symlinking to it
* run `npm install` in `/ide/work` directory

### 0.1.1 (8 Sep 2016)

* Install npm packages using package.json into `/home/ide/node/node_modules`
* symlink `/home/ide/node/node_modules` to `/ide/work/node_modules`
 in entrypoint

### 0.1.0 (7 Sep 2016)

Initial release.
