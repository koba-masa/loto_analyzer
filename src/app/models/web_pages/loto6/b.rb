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
          loto = Loto.new(kind: :loto6, times: times(row), lottery_date: nil)
          numbers = []
          prizes = []
          Result.new(loto, numbers, prizes)
        end
      ensure
        close()
        quit()
      end

      def times(row)
        source = parse_by_css_selector(row.to_s, 'tr th')
        match(source.inner_text, '第([0-9]{1,})回')
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
