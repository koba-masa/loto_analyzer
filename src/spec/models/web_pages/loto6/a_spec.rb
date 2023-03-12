# frozen_string_literal: true

require 'rails_helper'

module WebPages
  module Loto6
    RSpec.describe A do
      let(:instance_single) { described_class.new(url_single) }
      let(:instance_multiple) { described_class.new(url_multiple) }
      let(:url_single) { 'http://web/loto6/index_single.html' }
      let(:url_multiple) { 'http://web/loto6/index_multiple.html' }
      let(:expected_numbers) { %w[02 06 20 30 31 41] }

      after do
        instance_single.close
        instance_single.quit
      end

      describe '#initialize' do
        it 'インスタンス生成時にページの移動が完了していること' do
          expect(instance_single.driver.current_url).to eq url_single
        end
      end

      describe '#times' do
        it '開催回を返却すること' do
          expect(instance_single.times).to eq '1763'
        end
      end

      describe '#lottery_date' do
        it '抽せん日を返却すること' do
          expect(instance_single.lottery_date).to eq Date.new(2023, 2, 2)
        end
      end

      describe '#numbers' do
        it '本数字の配列を返却すること' do
          expect(instance_single.numbers).to match_array expected_numbers
        end
      end

      describe '#bounus_number' do
        it 'ボーナス数字を返却すること' do
          expect(instance_single.bounus_number).to eq '11'
        end
      end
    end
  end
end
