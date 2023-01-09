# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loto do
  describe 'バリデーション' do
    let(:loto) { build(:loto) }

    describe '#type' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto).to be_valid
          loto.type = described_class.types[:loto7]
          expect(loto).to be_valid
          loto.type = described_class.types[:mini_loto]
          expect(loto).to be_valid
        end
      end

      context '設定されていない場合' do
        it 'falseが返却されること' do
          loto.type = nil
          expect(loto).to be_invalid
        end
      end

      context '未定義の値の場合' do
        it 'falseが返却されること' do
          loto.type = 0
          expect(loto).to be_invalid
        end
      end
    end

    describe '#times' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto).to be_valid
        end
      end

      context '設定されていない場合' do
        it 'falseが返却されること' do
          loto.times = nil
          expect(loto).to be_invalid
        end
      end
    end

    describe '#lottery_date' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto).to be_valid
        end
      end

      context '設定されていない場合' do
        it 'falseが返却されること' do
          loto.lottery_date = nil
          expect(loto).to be_invalid
        end
      end
    end

    describe '#sales_amount' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto).to be_valid
          loto.sales_amount = 0
          expect(loto).to be_valid
        end
      end

      context '設定されていない場合' do
        it 'trueが返却されること' do
          loto.sales_amount = nil
          expect(loto).to be_valid
        end
      end
    end

    describe '#複合ユニークキー(type&times)' do
      before { create(:loto) }

      context '種別と開催回の組み合わせが未登録の場合' do
        it 'trueが返却されること' do
          loto.times = 11
          expect(loto).to be_valid
        end
      end

      context '種別と開催回の組み合わせが登録済みの場合' do
        it 'falseが返却されること' do
          expect(loto).to be_invalid
        end
      end
    end
  end
end
