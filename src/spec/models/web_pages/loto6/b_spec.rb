# frozen_string_literal: true

require 'rails_helper'

module WebPages
  module Loto6
    RSpec.describe B do
      let(:instance) { described_class.new(url) }
      let(:url) { 'http://web/loto6/backnumber/loto60001.html' }
      let(:expected_numbers) { %w[02 08 10 13 27 30] }

      describe '#initialize' do
        it 'インスタンス生成時にページの移動が完了していること' do
          expect(instance.driver.current_url).to eq url
          instance.close()
          instance.quit()
        end
      end

      describe '#parse' do
        context '対象のテーブルが存在する場合' do
          it 'Resultクラスの配列が返却されること' do
            result = instance.parse[0]
            expect(result.class).to eq Result
            expect(result.loto.times).to eq 1
            expect(result.loto.lottery_date).to eq Date.new(2000, 10, 5)
          end
        end
      end
    end
  end
end
