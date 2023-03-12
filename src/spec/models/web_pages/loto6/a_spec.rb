# frozen_string_literal: true

require 'rails_helper'

module WebPages
  module Loto6
    RSpec.describe A do
      let(:instance) { described_class.new(url) }
      let(:url) { 'http://web/loto6/index.html' }
      let(:expected_numbers) { %w[02 06 20 30 31 41] }

      after do
        instance.close
        instance.quit
      end

      describe '#initialize' do
        it 'インスタンス生成時にページの移動が完了していること' do
          expect(instance.driver.current_url).to eq url
        end
      end

      describe '#times' do
        it '開催回を返却すること' do
          expect(instance.times).to eq '1763'
        end
      end

      describe '#lottery_date' do
        it '抽せん日を返却すること' do
          expect(instance.lottery_date).to eq Date.new(2023, 2, 2)
        end
      end

      describe '#numbers' do
        it '本数字の配列を返却すること' do
          expect(instance.numbers).to match_array expected_numbers
        end
      end

      describe '#bounus_number' do
        it 'ボーナス数字を返却すること' do
          expect(instance.bounus_number).to eq '11'
        end
      end
    end
  end
end
