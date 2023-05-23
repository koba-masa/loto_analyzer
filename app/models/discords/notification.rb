# frozen_string_literal: true

module Discords
  class Notification
    include Singleton

    def initialize
      @client = Discordrb::Webhooks::Client.new(url: webhook_url)
    end

    def notify(title, contents)
      @client.execute do |builder|
        builder.add_embed do |embed|
          embed.title = title
          embed.description = contents
        end
      end
    end

    private

    def webhook_url
      Settings.discord.notification.webhook_url
    end
  end
end
