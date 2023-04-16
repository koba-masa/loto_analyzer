# frozen_string_literal: true

class Loto6RegistrationJob < ApplicationJob
  queue_as :default

  def perform
    results = []

    list = WebPages::List.new(Settings.loto.loto6.back_number)
    list.parse

    a_urls = list.loto6_a
    a_urls.push(Settings.loto.loto6.latest)

    results.concat(page_parse(WebPages::Loto6::A, a_urls))

    b_urls = list.loto6_b
    results.concat(page_parse(WebPages::Loto6::B, b_urls))

    results.each do |result|
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
