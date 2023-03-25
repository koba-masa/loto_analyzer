# frozen_string_literal: true

module WebPages
  module Loto6
    class Result
      attr_reader :loto, :numbers, :prizes

      def initialize(loto, numbers, prizes)
        @loto = loto
        @numbers = numbers
        @prizes = prizes
      end
    end
  end
end
