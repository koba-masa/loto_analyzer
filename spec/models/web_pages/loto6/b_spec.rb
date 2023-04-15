# frozen_string_literal: true

require 'rails_helper'

module WebPages
  module Loto6
    RSpec.describe B, type: :scraping do
      let(:instance) { described_class.new(url) }
      let(:url) { "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/loto/backnumber/loto60001.html" }
      let(:expected_numbers) { [2, 8, 10, 13, 27, 30, 39] }

      describe '#initialize' do
        it 'インスタンス生成時にページの移動が完了していること' do
          expect(instance.driver.current_url).to eq url
          instance.close
          instance.quit
        end
      end

      describe '#parse' do
        context '対象のテーブルが存在する場合' do
          it 'Resultクラスの配列が返却されること' do
            result = instance.parse[0]
            expect(result.class).to eq Result
            expect(result.loto.times).to eq 1
            expect(result.loto.lottery_date).to eq Date.new(2000, 10, 5)
            expect(result.numbers.map(&:number)).to match_array(expected_numbers)
            expect(result.prizes).to eq []
          end
        end
      end
    end
  end
end
