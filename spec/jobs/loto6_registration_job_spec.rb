# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loto6RegistrationJob, type: :scraping do
  let(:instance) { described_class.new }

  describe 'perform' do
    let(:mock) { instance_double(WebPages::List) }

    before do
      allow(WebPages::List).to receive(:new).and_return(mock)
      allow(mock).to receive(:parse)
      allow(mock).to receive(:loto6_a).and_return([])
      allow(mock).to receive(:loto6_b).and_return(
        [
          "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/loto/backnumber/loto60001.html",
        ],
      )
    end

    it 'ロト、ロトナンバーが登録されること' do
      expect { instance.perform }.to \
        change { Loto.all.size }.and \
          change { LotoNumber.all.size }
    end
  end
end
