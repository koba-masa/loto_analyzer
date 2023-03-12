# frozen_string_literal: true

module WebPages
  module Loto6
    class A < WebPage
      TABLE_CSS_SELECTOR = 'table.typeTK'
      THEAD_CSS_SELECTOR = "#{TABLE_CSS_SELECTOR} thead".freeze
      TBODY_CSS_SELECTOR = "#{TABLE_CSS_SELECTOR} tbody".freeze

      def initialize(url)
        get(url)
      end

      def times
        times = driver.find_element(:css, "#{THEAD_CSS_SELECTOR} tr th:nth-child(2)").text
        match(times, '第([0-9]{1,})回')
      end

      def lottery_date
        lottery_date = driver.find_element(:css, "#{TBODY_CSS_SELECTOR} tr:nth-child(1) td").text
        Date.new(
          match(lottery_date, '([0-9]{4})年[0-9]{1,2}月[0-9]{1,2}日').to_i,
          match(lottery_date, '[0-9]{4}年([0-9]{1,2})月[0-9]{1,2}日').to_i,
          match(lottery_date, '[0-9]{4}年[0-9]{1,2}月([0-9]{1,2})日').to_i,
        )
      end

      def numbers
        driver.find_elements(:css, "#{TBODY_CSS_SELECTOR} tr:nth-child(2) td strong").map(&:text)
      end

      def bounus_number
        bounus_number = driver.find_element(:css, "#{TBODY_CSS_SELECTOR} tr:nth-child(3) td strong").text
        match(bounus_number, '\(([0-9]{2})\)')
      end

      private

      def match(target, pattern)
        m = Regexp.new(pattern).match(target)
        return nil if m.nil? || m[1].nil?

        m[1]
      end
    end
  end
end
