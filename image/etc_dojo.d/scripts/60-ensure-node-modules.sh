#!/bin/bash

# this must be invoked after uid:gid of dojo user is changed
if [ -d "${dojo_work}/node_modules" ]; then
  echo "${dojo_work}/node_modules exist, nothing to do"
elif [ -d "${dojo_home}/hexoide-yarn/node_modules" ]; then
  set -x
  cp -r "${dojo_home}/hexoide-yarn/node_modules" "${dojo_work}"
  chown dojo:dojo -R "${dojo_work}/node_modules"
  set +x
fi
