# frozen_string_literal: true

module WebPages
  module Loto6
    class A < WebPage
      TABLE_CSS_SELECTOR = 'table.typeTK'
      THEAD_CSS_SELECTOR = "#{TABLE_CSS_SELECTOR} thead".freeze
      TBODY_CSS_SELECTOR = "#{TABLE_CSS_SELECTOR} tbody".freeze

      def initialize(url)
        super
        get(url)
      end

      def parse
        (0..(results_count - 1)).map do |i|
          loto = Loto.new(kind: :loto6, times: times(i), lottery_date: lottery_date(i))
          numbers = numbers(i).map { |number| LotoNumber.new(loto:, is_bonus: false, number:) }
          numbers.push(LotoNumber.new(loto:, is_bonus: true, number: bounus_number(i)))
          prizes = []
          Result.new(loto, numbers, prizes)
        end
      end

      def results_count
        @results_count ||= driver.find_elements(:css, TABLE_CSS_SELECTOR).size
        @results_count
      end

      def times(index)
        @timeses ||= driver.find_elements(:css, "#{THEAD_CSS_SELECTOR} tr th:nth-child(2)")
        times = @timeses[index].text
        match(times, '第([0-9]{1,})回')
      end

      def lottery_date(index)
        @lottery_dates ||= driver.find_elements(:css, "#{TBODY_CSS_SELECTOR} tr:nth-child(1) td")
        lottery_date = @lottery_dates[index].text
        Date.new(
          match(lottery_date, '([0-9]{4})年[0-9]{1,2}月[0-9]{1,2}日').to_i,
          match(lottery_date, '[0-9]{4}年([0-9]{1,2})月[0-9]{1,2}日').to_i,
          match(lottery_date, '[0-9]{4}年[0-9]{1,2}月([0-9]{1,2})日').to_i,
        )
      end

      def numbers(index)
        @numberses ||= driver.find_elements(:css, "#{TBODY_CSS_SELECTOR} tr:nth-child(2) td strong")
        start_index = index * 6
        end_index = (start_index + 6) - 1
        (start_index..end_index).map { |i| @numberses[i].text }
      end

      def bounus_number(index)
        @bounus_numbers ||= driver.find_elements(:css, "#{TBODY_CSS_SELECTOR} tr:nth-child(3) td strong")
        bounus_number = @bounus_numbers[index].text
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
