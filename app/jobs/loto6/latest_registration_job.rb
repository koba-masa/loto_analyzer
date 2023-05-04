# frozen_string_literal: true

module Loto6
  class LatestRegistrationJob < ApplicationJob
    queue_as :default
    sidekiq_options retry: false

    def perform(url = Settings.loto.loto6.latest)
      results = []

      results.concat(WebPages::Loto6::A.new(url).parse)

      results.each do |result|
        next if Loto.exists?(kind: result.loto.kind, times: result.loto.times)

        result.loto.save!
        result.numbers.each(&:save!)
        result.prizes.each(&:save!)
      end
    end
  end
end
