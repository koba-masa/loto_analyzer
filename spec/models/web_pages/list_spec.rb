# frozen_string_literal: true

require 'rails_helper'

module WebPages
  RSpec.describe List do
    let(:instance) { described_class.new(url) }
    let(:url) { 'http://web/loto/backnumber/index.html' }

    describe '#initialize' do
      it 'インスタンス生成時にページの移動が完了していること' do
        expect(instance.driver.current_url).to eq url
        instance.close
        instance.quit
      end
    end

    describe '#parse' do
      subject { instance.parse }

      it 'ロト6のバックナンバーが格納されていること' do
        subject
        expect(instance.loto6).to include(
          'http://web/retail/takarakuji/check/loto/loto6/index.html?year=2023&month=1',
          'http://web/loto6/backnumber/loto60081.html'
        )
      end
    end
  end
end
