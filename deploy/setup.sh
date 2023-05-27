#!/bin/bash

bundle config set --local without 'test development'
bundle install
bundle exec rails db:migrate
