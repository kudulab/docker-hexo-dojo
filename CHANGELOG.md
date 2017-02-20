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
