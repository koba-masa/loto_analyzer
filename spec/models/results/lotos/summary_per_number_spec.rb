# frozen_string_literal: true

require 'rails_helper'

module Results
  module Lotos
    RSpec.describe SummaryPerNumber do
      describe 'create' do
        before do
          loto1
          loto1_number1
          loto1_number2
          loto1_number3
          loto1_number4
          loto1_number5
          loto1_number6
          loto1_number_bounus

          loto2
          loto2_number1
          loto2_number2
          loto2_number3
          loto2_number4
          loto2_number5
          loto2_number6
          loto2_number_bounus

          loto3
          loto3_number1
          loto3_number2
          loto3_number3
          loto3_number4
          loto3_number5
          loto3_number6
          loto3_number7
          loto3_number_bounus
        end

        after do
          Rails.root.glob('tmp/cache/files/test/**/*') do |item|
            File.delete(item) if File.file?(item)
          end
        end

        let(:kind_miniloto) { ::Loto.kinds[:mini_loto] }
        let(:kind_loto6) { ::Loto.kinds[:loto6] }
        let(:kind_loto7) { ::Loto.kinds[:loto7] }

        let(:loto1) { create(:loto, kind: kind_loto6, times: 10) }
        let(:loto1_number1) { create(:loto_number, loto: loto1, number: 1) }
        let(:loto1_number2) { create(:loto_number, loto: loto1, number: 2) }
        let(:loto1_number3) { create(:loto_number, loto: loto1, number: 3) }
        let(:loto1_number4) { create(:loto_number, loto: loto1, number: 4) }
        let(:loto1_number5) { create(:loto_number, loto: loto1, number: 5) }
        let(:loto1_number6) { create(:loto_number, loto: loto1, number: 6) }
        let(:loto1_number_bounus) { create(:loto_number, :is_bonus, loto: loto1, number: 7) }

        let(:loto2) { create(:loto, kind: kind_loto6, times: 11) }
        let(:loto2_number1) { create(:loto_number, loto: loto2, number: 1) }
        let(:loto2_number2) { create(:loto_number, loto: loto2, number: 3) }
        let(:loto2_number3) { create(:loto_number, loto: loto2, number: 7) }
        let(:loto2_number4) { create(:loto_number, loto: loto2, number: 12) }
        let(:loto2_number5) { create(:loto_number, loto: loto2, number: 30) }
        let(:loto2_number6) { create(:loto_number, loto: loto2, number: 32) }
        let(:loto2_number_bounus) { create(:loto_number, :is_bonus, loto: loto2, number: 20) }

        let(:loto3) { create(:loto, kind: kind_loto7, times: 11) }
        let(:loto3_number1) { create(:loto_number, loto: loto3, number: 1) }
        let(:loto3_number2) { create(:loto_number, loto: loto3, number: 2) }
        let(:loto3_number3) { create(:loto_number, loto: loto3, number: 3) }
        let(:loto3_number4) { create(:loto_number, loto: loto3, number: 4) }
        let(:loto3_number5) { create(:loto_number, loto: loto3, number: 5) }
        let(:loto3_number6) { create(:loto_number, loto: loto3, number: 6) }
        let(:loto3_number7) { create(:loto_number, loto: loto3, number: 7) }
        let(:loto3_number_bounus) { create(:loto_number, :is_bonus, loto: loto3, number: 8) }

        context '結果が存在する場合' do
          let(:kind) { 'loto6' }
          let(:expected_file_path) { Rails.root.join('tmp/cache/files/test/lotos/loto6/summary_per_numbers.json') }
          let(:expected_contents) { file_fixture('lotos/loto6/summary_per_number.json').read }

          it 'ファイルが作成されること' do
            described_class.new(kind).create
            expect(File).to exist(expected_file_path)
            expect(File.read(expected_file_path)).to eq(expected_contents)
          end
        end

        context '結果が存在しない場合' do
          let(:kind) { 'mini_loto' }
          let(:expected_file_path) { Rails.root.join('tmp/cache/files/test/lotos/mini_loto/summary_per_numbers.json') }
          let(:expected_contents) { file_fixture('lotos/mini_loto/summary_per_number_empty.json').read }

          it '空のファイルが作成されること' do
            described_class.new(kind).create
            expect(File).to exist(expected_file_path)
            expect(File.read(expected_file_path)).to eq(expected_contents)
          end
        end
      end
    end
  end
end
