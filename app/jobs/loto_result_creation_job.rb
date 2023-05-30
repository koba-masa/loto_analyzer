# frozen_string_literal: true

class LotoResultCreationJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(kind)
    raise ArgumentError, "This kind is not defined.: #{kind}" unless Loto.kinds.key?(kind)

    # TODO: Discordに通知する処理を実装する

    ::Results::Lotos::WinningResult.new(kind).create
  end
end
