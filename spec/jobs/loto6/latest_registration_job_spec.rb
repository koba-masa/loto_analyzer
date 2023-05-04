# frozen_string_literal: true

require 'rails_helper'

module Loto6
  RSpec.describe LatestRegistrationJob, type: :scraping do
    let(:instance) { described_class.new }

    describe 'perform' do
      context '引数を指定しない場合' do
        context '未登録の場合' do
          it 'ロト、ロトナンバーが登録されること' do
            expect { instance.perform }.to \
              change(Loto.all, :size).and \
                change(LotoNumber.all, :size)
            expect(Loto).not_to exist(kind: Loto.kinds[:loto6], times: 1763)
          end
        end

        context '登録済みの場合' do
          it 'ロト、ロトナンバーが登録されないこと' do
            instance.perform
            expect { instance.perform }.not_to change(Loto.all, :size)
          end
        end
      end

      context '引数を指定した場合' do
        let(:url) { "http://#{ENV.fetch('TEST_WEB_SERVER', nil)}/loto/loto6/index_single.html" }

        it 'ロト、ロトナンバーが登録されること' do
          expect { instance.perform(url) }.to \
            change(Loto.all, :size).and \
              change(LotoNumber.all, :size)
          expect(Loto).to exist(kind: Loto.kinds[:loto6], times: 1763)
        end
      end
    end
  end
end
