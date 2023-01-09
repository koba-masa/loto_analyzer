# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LotoPrize do
  describe 'バリデーション' do
    let(:loto_prize) { build(:loto_prize) }

    describe '#grade' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto_prize).to be_valid
          loto_prize.grade = 2
          expect(loto_prize).to be_valid
        end
      end

      context '0以下の値が設定されている場合' do
        it 'falseが返却されること' do
          loto_prize.grade = 0
          expect(loto_prize).to be_invalid
          loto_prize.grade = -1
          expect(loto_prize).to be_invalid
        end
      end

      context '設定されていない場合' do
        it 'falseが返却されること' do
          loto_prize.grade = nil
          expect(loto_prize).to be_invalid
        end
      end
    end

    describe '#winning_number' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto_prize).to be_valid
          loto_prize.winning_number = 0
          expect(loto_prize).to be_valid
        end
      end

      context '設定されていない場合' do
        it 'trueが返却されること' do
          loto_prize.winning_number = nil
          expect(loto_prize).to be_valid
        end
      end

      context '0未満の値の場合' do
        it 'falseが返却されること' do
          loto_prize.winning_number = -1
          expect(loto_prize).to be_invalid
        end
      end
    end

    describe '#winning_aoumnt' do
      context '設定されている場合' do
        it 'trueが返却されること' do
          expect(loto_prize).to be_valid
          loto_prize.winning_aoumnt = 0
          expect(loto_prize).to be_valid
        end
      end

      context '設定されていない場合' do
        it 'trueが返却されること' do
          loto_prize.winning_aoumnt = nil
          expect(loto_prize).to be_valid
        end
      end

      context '0未満の値の場合' do
        it 'falseが返却されること' do
          loto_prize.winning_aoumnt = -1
          expect(loto_prize).to be_invalid
        end
      end
    end
  end
end
