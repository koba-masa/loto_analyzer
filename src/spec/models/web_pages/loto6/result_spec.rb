# frozen_string_literal: true

require 'rails_helper'

module WebPages
  module Loto6
    RSpec.describe Result do
      let(:instance) { described_class.new(Loto.new, [LotoNumber.new], [LotoPrize.new]) }

      describe '属性値の確認' do
        it 'lotoが存在すること' do
          expect(instance.loto).not_to be_nil
        end

        it 'numberが存在すること' do
          expect(instance.numbers).not_to be_nil
        end

        it 'prizeが存在すること' do
          expect(instance.prizes).not_to be_nil
        end
      end
    end
  end
end
