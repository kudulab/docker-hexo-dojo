#!/bin/bash

# this must be invoked after uid:gid of ide user is changed
if [ -d "${ide_work}/node_modules" ]; then
  echo "${ide_work}/node_modules exist, nothing to do"
elif [ -d "${ide_home}/node_modules" ]; then
  echo "${ide_work}/node_modules does not exist but ${ide_home}/node_modules does, (this image is warmed up)"
  echo "copying ${ide_home}/node_modules into ${ide_work}"
  set -x
  cp -r "${ide_home}/node_modules" "${ide_work}"
  chown ide:ide -R "${ide_work}/node_modules"
  set +x
fi
