require 'rails_helper'

module WebPages
  RSpec.describe Loto6, type: :model do
    let(:instance) { described_class.new }
    let(:url) { 'http://web:80/loto6/index.html' }

    before do
      instance.get(url)
    end

    after do
      instance.close
      instance.quit
    end

    describe 'get' do
      it 'ロト6のページの内容が取得できること' do
        expect(instance.driver.page_source).not_to eq nil
      end
    end

    describe '#times' do
      it '開催回を返却すること' do
        expect(instance.times).to eq '1763'
      end
    end
  end
end
