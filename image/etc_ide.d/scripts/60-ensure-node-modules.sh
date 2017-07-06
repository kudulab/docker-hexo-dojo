#!/bin/bash

# this must be invoked after uid:gid of ide user is changed
if [ -d "${ide_work}/node_modules" ]; then
  echo "${ide_work}/node_modules exist, nothing to do"
elif [ -d "${ide_home}/hexoide-yarn/node_modules" ]; then
  set -x
  cp -r "${ide_home}/hexoide-yarn/node_modules" "${ide_work}"
  chown ide:ide -R "${ide_work}/node_modules"
  set +x
fi
