# frozen_string_literal: true

require 'rails_helper'

module WebPages
  module Loto6
    RSpec.describe A, type: :scraping do
      let(:instance_single) { described_class.new(url_single) }
      let(:instance_multiple) { described_class.new(url_multiple) }
      let(:url_single) { "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/loto/loto6/index_single.html" }
      let(:url_multiple) { "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/loto/loto6/index_multiple.html" }
      let(:expected_numbers) { %w[02 06 20 30 31 41] }

      describe '#initialize' do
        it 'インスタンス生成時にページの移動が完了していること' do
          expect(instance_single.driver.current_url).to eq url_single
          instance_single.close
          instance_single.quit
        end
      end

      describe '#parse' do
        context '対象のテーブルが存在する場合' do
          it 'Resultクラスの配列が返却されること' do
            result = instance_single.parse[0]
            expect(result.class).to eq Result
            loto = result.loto
            expect(loto.kind).to eq Loto.kinds[:loto6]
          end
        end
      end

      describe '#results_count' do
        context '結果が1つ掲載されている場合' do
          it '1が返却されること' do
            expect(instance_single.results_count).to eq 1
            instance_single.close
            instance_single.quit
          end
        end

        context '結果が3つ掲載されている場合' do
          it '3が返却されること' do
            expect(instance_multiple.results_count).to eq 3
            instance_multiple.close
            instance_multiple.quit
          end
        end
      end

      describe '#times' do
        it '開催回を返却すること' do
          expect(instance_single.times(0)).to eq '1763'
          instance_single.close
          instance_single.quit

          expect(instance_multiple.times(0)).to eq '1773'
          expect(instance_multiple.times(1)).to eq '1772'
          expect(instance_multiple.times(2)).to eq '1771'
          instance_multiple.close
          instance_multiple.quit
        end
      end

      describe '#lottery_date' do
        it '抽せん日を返却すること' do
          expect(instance_single.lottery_date(0)).to eq Date.new(2023, 2, 2)
          instance_single.close
          instance_single.quit

          expect(instance_multiple.lottery_date(0)).to eq Date.new(2023, 3, 9)
          expect(instance_multiple.lottery_date(1)).to eq Date.new(2023, 3, 6)
          expect(instance_multiple.lottery_date(2)).to eq Date.new(2023, 3, 2)
          instance_multiple.close
          instance_multiple.quit
        end
      end

      describe '#numbers' do
        it '本数字の配列を返却すること' do
          expect(instance_single.numbers(0)).to match_array expected_numbers
          instance_single.close
          instance_single.quit

          expect(instance_multiple.numbers(0)).to match_array %w[12 21 22 27 31 32]
          expect(instance_multiple.numbers(1)).to match_array %w[05 21 22 30 32 36]
          expect(instance_multiple.numbers(2)).to match_array %w[03 06 12 16 31 42]
          instance_multiple.close
          instance_multiple.quit
        end
      end

      describe '#bounus_number' do
        it 'ボーナス数字を返却すること' do
          expect(instance_single.bounus_number(0)).to eq '11'
          instance_single.close
          instance_single.quit

          expect(instance_multiple.bounus_number(0)).to eq '20'
          expect(instance_multiple.bounus_number(1)).to eq '16'
          expect(instance_multiple.bounus_number(2)).to eq '40'
          instance_multiple.close
          instance_multiple.quit
        end
      end
    end
  end
end
