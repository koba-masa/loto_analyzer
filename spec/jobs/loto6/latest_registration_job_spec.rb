# frozen_string_literal: true

require 'rails_helper'

module Loto6
  RSpec.describe LatestRegistrationJob, type: :scraping do
    let(:instance) { described_class.new }

    describe 'perform' do
      context '未登録の場合' do
        it 'ロト、ロトナンバーが登録されること' do
          expect { instance.perform }.to \
            change(Loto.all, :size).and \
              change(LotoNumber.all, :size)
        end
      end

      context '登録済みの場合' do
        it 'ロト、ロトナンバーが登録されないこと' do
          instance.perform
          expect { instance.perform }.not_to change(Loto.all, :size)
        end
      end
    end
  end
end
