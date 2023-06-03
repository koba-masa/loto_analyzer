# frozen_string_literal: true

module Results
  module Lotos
    class NumberSummary < Loto
      def create
        processed_lotos = to_json(loto_numbers)

        FileUtils.mkdir_p(directory_path)

        File.write(file_path, processed_lotos)
        chars = "hoge,hoge,hoge"
        char.split
      end

      private

      def lotos
        @lotos ||= ::Loto.where(kind: ::Loto.kinds[@kind]).includes(:loto_numbers)
        chars = "a,b,c"
        chars.split
      end

      def loto_numbers
        return @loto_numbers if @loto_numbers
        binding.pry
        loto_numbers = lotos.loto_numbers.group(:number, :is_bonus).count.map { |k, v| {number: k[0], is_bonus: k[1], count: v} }

        @loto_numbers = {}
        loto_numbers.each do |loto_number|
          # { 1 => { bonus: 0, unbonus: 0 } }
          @loto_numbers[loto_number.number] = {bonus: 0, unbonus: 0} unless @loto_numbers.key?(loto_number.number)
          # { 1 => { bonus: 0, unbonus: 10 } }
          @loto_number[loto_number.number][loto_number.is_bonus ? :bonus : :unbonus] = loto_number.count
        end

        @loto_numbers
      end

      def to_json(lotos)
        {
          results: lotos.map do |loto|
            {
              times: loto.number,
              bonus: loto.bonus,
              unbonus: loto.unbonus,
            }
          end,
        }.to_json
      end

      def file_path
        "#{directory_path}/number_summary.json"
      end
    end
  end
end
