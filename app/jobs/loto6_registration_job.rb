# frozen_string_literal: true

class Loto6RegistrationJob < ApplicationJob
  queue_as :default

  def perform
    results = []

    list = WebPages::List.new(Settings.loto.loto6.back_number)
    list.parse

    a_urls = list.loto6_a
    a_urls.push(Settings.loto.loto6.latest)

    results.concat(
      a_urls.map do |url|
        WebPages::Loto6::A.new(url).parse
      rescue StandardError => e
        logger.error e.message.to_s
        logger.info e.backtrace.join("\n").to_s
      end.flatten,
    )

    b_urls = list.loto6_b
    results.concat(
      b_urls.map do |url|
        WebPages::Loto6::B.new(url).parse
      rescue StandardError => e
        logger.error e.message.to_s
        logger.info e.backtrace.join("\n").to_s
      end.flatten,
    )

    results.each do |result|
      result.loto.save!
      result.numbers.each(&:save!)
      result.prizes.each(&:save!)
    end
    binding.pry
  end
end
