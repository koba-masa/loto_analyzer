# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebPage do
  let(:instance) { described_class.new }
  let(:url) { "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/loto6/index.html" }

  before do
    instance.get(url)
  end

  after do
    instance.close
    instance.quit
  end

  describe 'get' do
    it 'ロト6のページの内容が取得できること' do
      expect(instance.driver.page_source).not_to be_nil
    end
  end
end
