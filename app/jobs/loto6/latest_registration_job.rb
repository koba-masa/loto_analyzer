# frozen_string_literal: true

module Loto6
  class LatestRegistrationJob < ApplicationJob
    queue_as :default
    sidekiq_options retry: false

    def perform
      results = []

      results.concat(page_parse(WebPages::Loto6::A, [Settings.loto.loto6.latest]))

      results.each do |result|
        next if Loto.exists?(kind: result.loto.kind, times: result.loto.times)

        result.loto.save!
        result.numbers.each(&:save!)
        result.prizes.each(&:save!)
      end
    end

    private

    def page_parse(page_class, urls)
      urls.map do |url|
        sleep Settings.jobs.loto6_registration_job.sleep
        page_class.new(url).parse
      rescue StandardError => e
        logger.error e.message.to_s
        logger.info e.backtrace.join("\n").to_s
      end.flatten
    end
  end
end
