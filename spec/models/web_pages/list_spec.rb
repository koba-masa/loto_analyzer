# frozen_string_literal: true

require 'rails_helper'

module WebPages
  RSpec.describe List, type: :scraping do
    let(:instance) { described_class.new(url) }
    let(:url) { "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/loto/backnumber/index.html" }

    describe '#initialize' do
      it 'インスタンス生成時にページの移動が完了していること' do
        expect(instance.driver.current_url).to eq url
        instance.close
        instance.quit
      end
    end

    describe '#parse' do
      it 'ロト6のバックナンバーが格納されていること' do
        instance.parse
        expect(instance.loto6_a).to include(
          "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/retail/takarakuji/check/loto/loto6/index.html?year=2023&month=1",
        )
        expect(instance.loto6_b).to include(
          "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/loto6/backnumber/loto60081.html",
        )
      end
    end
  end
end
