#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
cd ${BASE_DIR}

source ~/.bash_profile

git checkout main
git fetch
git pull

bundle install --without test development
bundle exec rails db:migrate RAILS_ENV=production

SOCKET_DIR=tmp/sockets
if [ ! -d "${SOCKET_DIR}" ]; then
  mkdir -p ${SOCKET_DIR}
fi

sudo systemctl stop nginx
sudo systemctl stop loto_analyzer_puma.service
sudo systemctl stop loto_analyzer_sidekiq.service

sudo systemctl start loto_analyzer_sidekiq.service
sudo systemctl start loto_analyzer_puma.service
sudo systemctl start nginx
