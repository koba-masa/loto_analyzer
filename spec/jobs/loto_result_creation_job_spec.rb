# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LotoResultCreationJob do
  let(:instance) { described_class.new }

  describe 'perform' do
    subject(:perform) { instance.perform(kind) }

    before do
      loto1
      loto1_number1
      loto1_number2
      loto1_number3
      loto1_number4
      loto1_number5
      loto1_number6
      loto1_number_bounus

      loto2
      loto2_number1
      loto2_number2
      loto2_number3
      loto2_number4
      loto2_number5
      loto2_number6
      loto2_number_bounus

      loto3
      loto3_number1
      loto3_number2
      loto3_number3
      loto3_number4
      loto3_number5
      loto3_number6
      loto3_number7
      loto3_number_bounus
    end

    after do
      Rails.root.glob('tmp/cache/files/test/**/*') do |item|
        File.delete(item) if File.file?(item)
      end
    end

    let(:kind_miniloto) { Loto.kinds[:mini_loto] }
    let(:kind_loto6) { Loto.kinds[:loto6] }
    let(:kind_loto7) { Loto.kinds[:loto7] }

    let(:loto1) { create(:loto, kind: kind_loto6, times: 10) }
    let(:loto1_number1) { create(:loto_number, loto: loto1, number: 1) }
    let(:loto1_number2) { create(:loto_number, loto: loto1, number: 2) }
    let(:loto1_number3) { create(:loto_number, loto: loto1, number: 3) }
    let(:loto1_number4) { create(:loto_number, loto: loto1, number: 4) }
    let(:loto1_number5) { create(:loto_number, loto: loto1, number: 5) }
    let(:loto1_number6) { create(:loto_number, loto: loto1, number: 6) }
    let(:loto1_number_bounus) { create(:loto_number, :is_bonus, loto: loto1, number: 7) }

    let(:loto2) { create(:loto, kind: kind_loto6, times: 11) }
    let(:loto2_number1) { create(:loto_number, loto: loto2, number: 10) }
    let(:loto2_number2) { create(:loto_number, loto: loto2, number: 21) }
    let(:loto2_number3) { create(:loto_number, loto: loto2, number: 32) }
    let(:loto2_number4) { create(:loto_number, loto: loto2, number: 33) }
    let(:loto2_number5) { create(:loto_number, loto: loto2, number: 38) }
    let(:loto2_number6) { create(:loto_number, loto: loto2, number: 41) }
    let(:loto2_number_bounus) { create(:loto_number, :is_bonus, loto: loto2, number: 20) }

    let(:loto3) { create(:loto, kind: kind_loto7, times: 11) }
    let(:loto3_number1) { create(:loto_number, loto: loto3, number: 12) }
    let(:loto3_number2) { create(:loto_number, loto: loto3, number: 21) }
    let(:loto3_number3) { create(:loto_number, loto: loto3, number: 32) }
    let(:loto3_number4) { create(:loto_number, loto: loto3, number: 33) }
    let(:loto3_number5) { create(:loto_number, loto: loto3, number: 38) }
    let(:loto3_number6) { create(:loto_number, loto: loto3, number: 41) }
    let(:loto3_number7) { create(:loto_number, loto: loto3, number: 45) }
    let(:loto3_number_bounus) { create(:loto_number, :is_bonus, loto: loto3, number: 8) }

    context '存在するロト種別の場合' do
      context '結果が存在する場合' do
        let(:kind) { 'loto6' }
        let(:expected_file_path) { Rails.root.join('tmp/cache/files/test/loto/result/loto6.json') }
        let(:expected_contents) { file_fixture('loto/result/loto6/loto6.json').read }

        it 'ファイルが作成されること' do
          perform
          expect(File).to exist(expected_file_path)
          expect(File.read(expected_file_path)).to eq(expected_contents)
        end
      end

      context '結果が存在しない場合' do
        let(:kind) { 'mini_loto' }
        let(:expected_file_path) { Rails.root.join('tmp/cache/files/test/loto/result/mini_loto.json') }
        let(:expected_contents) { file_fixture('loto/result/mini_loto/empty.json').read }

        it '空のファイルが作成されること' do
          perform
          expect(File).to exist(expected_file_path)
          expect(File.read(expected_file_path)).to eq(expected_contents)
        end
      end
    end

    context '存在しないロト種別の場合' do
      let(:kind) { 'sample' }

      it '例外が発生すること' do
        expect do
          perform
        end.to raise_error(ArgumentError)
      end
    end
  end
end
