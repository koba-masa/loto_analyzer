# frozen_string_literal: true

module Results
  module Lotos
    class SummaryPerNumber < Loto
      def create
        processed_lotos = to_json(loto_numbers)
        FileUtils.mkdir_p(directory_path)
        File.write(file_path, processed_lotos)
      end

      private

      def loto_numbers
        LotoNumber.joins(:loto).where(lotos: { kind: ::Loto.kinds[@kind] }).group(:number,
                                                                                  :is_bonus).order(:number).count
      end

      def to_json(loto_numbers)
        summary_data = {}
        loto_numbers.each do |key, value|
          number = key[0]
          is_bonus = key[1]

          summary_data[number] = { unbonus: 0, bonus: 0 } unless summary_data.key?(number)

          if is_bonus
            summary_data[number][:bonus] += value
          else
            summary_data[number][:unbonus] += value
          end
        end

        { results: summary_data.sort.to_h }.to_json
      end

      def file_path
        "#{directory_path}/summary_per_numbers.json"
      end
    end
  end
end
