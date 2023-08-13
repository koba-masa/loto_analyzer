# frozen_string_literal: true

module Results
  module Lotos
    class WinningResult < Loto
      def create
        processed_lotos = to_json(lotos)

        FileUtils.mkdir_p(directory_path)

        File.write(file_path, processed_lotos)
      end

      private

      def lotos
        @lotos ||= ::Loto.where(kind: ::Loto.kinds[@kind]).order(times: 'ASC').includes(:loto_numbers)
      end

      def to_json(lotos)
        {
          results: lotos.map do |loto|
            {
              times: loto.times,
              lottery_date: loto.lottery_date.strftime('%Y/%m/%d'),
              loto_numbers: loto.loto_numbers.unbouns.map(&:number),
              bounus_loto_number: loto.loto_numbers.bouns[0].number,
            }
          end,
        }.to_json
      end

      def file_path
        "#{directory_path}/winning_result.json"
      end
    end
  end
end
