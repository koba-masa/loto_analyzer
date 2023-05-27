# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use Rails.application.config.session_store, Rails.application.config.session_options

Rails.application.routes.draw do
  get 'loto/:kind', to: 'lotos#show', as: 'loto', format: 'json'

  Rails.application.routes.draw do
    mount Sidekiq::Web, at: '/sidekiq'
  end
end
