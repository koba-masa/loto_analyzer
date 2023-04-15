# frozen_string_literal: true

module WebPages
  class List < WebPage
    attr_reader :loto6

    TABLE_TYPE_A_CSS_SELECTOR = 'table.typeTK:not(.js-backnumber-b)'
    TABLE_TYPE_B_CSS_SELECTOR = 'table.typeTK.js-backnumber-b'

    def initialize(url)
      super()
      get(url)

      @loto6 = []
    end

    def parse
      @loto6.concat(get_link(TABLE_TYPE_A_CSS_SELECTOR, 3))
      @loto6.concat(get_link(TABLE_TYPE_B_CSS_SELECTOR, 2))
    ensure
      close
      quit
    end

    private

    def get_link(css_selector, child_index)
      results = driver.find_elements(:css, "#{css_selector} tbody tr td:nth-child(#{child_index}) a")
      results.map { |result| result.attribute(:href) }
    end
  end
end
