#!/bin/bash

# this must be invoked after uid:gid of ide user is changed
if [[ -d "${ide_home}/node_modules" ]]; then
  cp -R "${ide_home}/node_modules" "${ide_work}/node_modules"
fi
