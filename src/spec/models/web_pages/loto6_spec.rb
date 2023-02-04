require 'rails_helper'

module WebPages
  RSpec.describe Loto6, type: :model do
    let(:instance) { described_class.new }
    describe 'get' do
      after do
        instance.close
        instance.quit
      end

      it 'ロト6のページの内容が取得できること' do
        instance.get(instance.url)
        expect(instance.driver.page_source).not_to eq nil
      end
    end
  end
end
