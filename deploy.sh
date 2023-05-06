#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
cd ${BASE_DIR}

source ~/.bash_profile

git checkout main
git fetch
git pull

bash deploy/setup.sh

SOCKET_DIR=tmp/sockets
if [ ! -d "${SOCKET_DIR}" ]; then
  mkdir -p ${SOCKET_DIR}
fi

bash deploy/systemctl.sh
