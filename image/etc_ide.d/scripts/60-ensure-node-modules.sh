#!/bin/bash

# this must be invoked after uid:gid of ide user is changed
if [[ -d "${ide_home}/node_modules" ]]; then
  (set -x; cp -R "${ide_home}/node_modules" "${ide_work}/node_modules")
  (set -x; chown ide:ide -R "${ide_work}/node_modules")
else
  echo "${ide_home}/node_modules directory does not exist"
fi
