# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LotoNumber do
  describe 'バリデーション' do
    let(:loto_number) { build(:loto_number) }

    describe '#is_bonus' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto_number).to be_valid
          loto_number.is_bonus = false
          expect(loto_number).to be_valid
        end
      end

      context '設定されていない場合' do
        it 'falseが返却されること' do
          loto_number.is_bonus = nil
          expect(loto_number).to be_invalid
        end
      end
    end

    describe '#number' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto_number).to be_valid
        end
      end

      context '設定されていない場合' do
        it 'falseが返却されること' do
          loto_number.number = nil
          expect(loto_number).to be_invalid
        end
      end

      context '0以下の値の場合' do
        it 'falseが返却されること' do
          loto_number.number = 0
          expect(loto_number).to be_invalid
          loto_number.number = -1
          expect(loto_number).to be_invalid
        end
      end
    end

    describe '#複合ユニークキー(loto&number)' do
      before { create(:loto_number, loto:) }

      let(:loto) { create(:loto) }
      let(:unsaved_loto_numbers) { build(:loto_number, loto:, number: 2) }
      let(:saved_loto_numbers) { build(:loto_number, loto:) }

      context 'ロトIDと数字の組み合わせが未登録の場合' do
        it 'trueが返却されること' do
          expect(unsaved_loto_numbers).to be_valid
        end
      end

      context 'ロトIDと数字の組み合わせが登録済みの場合' do
        it 'falseが返却されること' do
          expect(saved_loto_numbers).to be_invalid
        end
      end
    end
  end
end
