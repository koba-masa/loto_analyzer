# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Discords::Notification do
  let(:instance) { described_class.instance }

  describe 'initialize' do
    it do
      expect(instance.class).to eq(described_class)
    end
  end

  describe 'notify' do
    subject(:notify) { instance.notify(title, contents) }

    let!(:title) { 'test' }
    let!(:contents) { 'This is test!' }

    it '正常に通知すること', skip: 'do not test when ci' do
      expect do
        notify
      end.not_to raise_error(StandardError)
    end
  end
end
