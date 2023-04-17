#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
cd ${BASE_DIR}

source ~/.bash_profile

git fetch
git pull

bundle install --without test development
bundle exec rails db:migrate RAILS_ENV=production

# TODO: ユニットファイル化したい
bundle exec sidekiq start --environment=production &
