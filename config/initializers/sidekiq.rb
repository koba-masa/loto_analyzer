# frozen_string_literal: true

host = Settings.redis.host
port = Settings.redis.port
db_index = Settings.redis.db_index

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{host}:#{port}/#{db_index}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{host}:#{port}/#{db_index}" }
end
