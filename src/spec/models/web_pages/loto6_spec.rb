require 'rails_helper'

module WebPages
  RSpec.describe Loto6, type: :model do
    let(:instance) { described_class.new }
    describe 'get' do
      it 'ロト6のページの内容が取得できること' do
        response = instance.get
        binding.pry
        expect(response.status).to contain_exactly('200', 'OK')
        expect(response.read).not_to be nil
      end
    end
  end
end
