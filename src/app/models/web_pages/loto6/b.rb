# frozen_string_literal: true

module WebPages
  module Loto6
    class B < WebPage
      TABLE_CSS_SELECTOR = 'div.spTableScroll table.typeTK'
      ROW_CSS_SELECTOR = "#{TABLE_CSS_SELECTOR} tbody tr".freeze

      def initialize(url)
        get(url)
      end

      def parse
        results = []
        row_source.map do |row|
          loto = Loto.new(kind: :loto6, times: times(row), lottery_date: lottery_date(row))
          prizes = []
          Result.new(loto, numbers, prizes)
          numbers = numbers(row).map { |number| LotoNumber.new(loto: loto, is_bonus: false, number: number) }
          numbers.push(LotoNumber.new(loto: loto, is_bonus: true, number: bounus_number(row)))
        end
      ensure
        close()
        quit()
      end

      def times(row)
        source = parse_by_css_selector(row.to_s, 'tr th')
        match(source.inner_text, '第([0-9]{1,})回')
      end

      def lottery_date(row)
        source = parse_by_css_selector(row.to_s, 'tr :nth-child(2)')
        Date.new(
          match(source.inner_text, '([0-9]{4})年[0-9]{1,2}月[0-9]{1,2}日').to_i,
          match(source.inner_text, '[0-9]{4}年([0-9]{1,2})月[0-9]{1,2}日').to_i,
          match(source.inner_text, '[0-9]{4}年[0-9]{1,2}月([0-9]{1,2})日').to_i,
        )
      end

      def numbers(row)
        source = parse_by_css_selector(row.to_s, 'tr :nth-child(n+3):nth-child(-n+8)')
        source.map { |number| number.inner_text }
      end

      def bounus_number(row)
        source = parse_by_css_selector(row.to_s, 'tr :nth-child(9)')
        source.inner_text
      end

      private

      def match(target, pattern)
        m = Regexp.new(pattern).match(target)
        return nil if m.nil? || m[1].nil?

        m[1]
      end

      def page_source
        @page_source ||= driver.page_source
      end

      def row_source
        @row_source ||= parse_by_css_selector(page_source, ROW_CSS_SELECTOR)
      end
    end
  end
end
