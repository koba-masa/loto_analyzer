#!/bin/bash

sudo systemctl stop nginx
sudo systemctl stop loto_analyzer_puma.service
sudo systemctl stop loto_analyzer_sidekiq.service

sudo systemctl start loto_analyzer_sidekiq.service
sudo systemctl start loto_analyzer_puma.service
sudo systemctl start nginx
