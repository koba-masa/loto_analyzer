# frozen_string_literal: true

require 'rails_helper'

module WebPages
  RSpec.describe Loto6 do
    let(:instance) { described_class.new }
    let(:url) { 'http://web:80/loto6/index.html' }
    let(:expected_numbers) { %w[02 06 20 30 31 41] }

    before do
      instance.get(url)
    end

    after do
      instance.close
      instance.quit
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
