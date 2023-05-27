# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Loto' do
  describe 'GET /loto/:kind' do
    subject(:request) { get loto_path(kind:) }

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

    let(:kind_miniloto) { Loto.kinds[:mini_loto] }
    let(:kind_loto6) { Loto.kinds[:loto6] }
    let(:kind_loto7) { Loto.kinds[:loto7] }

    let(:loto1) { create(:loto, kind: kind_loto6) }
    let(:loto1_number1) { create(:loto_number, loto: loto1, number: 1) }
    let(:loto1_number2) { create(:loto_number, loto: loto1, number: 2) }
    let(:loto1_number3) { create(:loto_number, loto: loto1, number: 3) }
    let(:loto1_number4) { create(:loto_number, loto: loto1, number: 4) }
    let(:loto1_number5) { create(:loto_number, loto: loto1, number: 5) }
    let(:loto1_number6) { create(:loto_number, loto: loto1, number: 6) }
    let(:loto1_number_bounus) { create(:loto_number, :is_bonus, loto: loto1, number: 7) }

    let(:loto2) { create(:loto, kind: kind_loto6) }
    let(:loto2_number1) { create(:loto_number, loto: loto2, number: 10) }
    let(:loto2_number2) { create(:loto_number, loto: loto2, number: 21) }
    let(:loto2_number3) { create(:loto_number, loto: loto2, number: 32) }
    let(:loto2_number4) { create(:loto_number, loto: loto2, number: 33) }
    let(:loto2_number5) { create(:loto_number, loto: loto2, number: 38) }
    let(:loto2_number6) { create(:loto_number, loto: loto2, number: 41) }
    let(:loto2_number_bounus) { create(:loto_number, :is_bonus, loto: loto2, number: 20) }

    let(:loto3) { create(:loto, kind: kind_loto7) }
    let(:loto3_number1) { create(:loto_number, loto: loto3, number: 10) }
    let(:loto3_number2) { create(:loto_number, loto: loto3, number: 21) }
    let(:loto3_number3) { create(:loto_number, loto: loto3, number: 32) }
    let(:loto3_number4) { create(:loto_number, loto: loto3, number: 33) }
    let(:loto3_number5) { create(:loto_number, loto: loto3, number: 38) }
    let(:loto3_number6) { create(:loto_number, loto: loto3, number: 41) }
    let(:loto3_number7) { create(:loto_number, loto: loto3, number: 42) }
    let(:loto3_number_bounus) { create(:loto_number, :is_bonus, loto: loto3, number: 7) }

    context '存在するロト種別の場合' do
      context 'ロト結果が存在する場合' do
        let(:kind) { kind_loto6 }
        let(:expected_result) do
          {
            'results' => [
              {
                'kind' => loto1.kind,
                'lottery_date' => loto1.lottery_date.strftime('%Y/%m/%d'),
                'sales_amount' => loto1.sales_amount,
                'loto_numbers' => [loto1_number1.number, loto1_number2.number, loto1_number3.number,
                                   loto1_number4.number, loto1_number5.number, loto1_number6.number],
                'bounus_loto_number' => loto1_number_bounus.number,
              },
              {
                'kind' => loto2.kind,
                'lottery_date' => loto2.lottery_date.strftime('%Y/%m/%d'),
                'sales_amount' => loto2.sales_amount,
                'loto_numbers' => [loto2_number1.number, loto2_number2.number, loto2_number3.number,
                                   loto2_number4.number, loto2_number5.number, loto2_number6.number],
                'bounus_loto_number' => loto2_number_bounus.number,
              },
            ],
          }
        end

        it '200が返却されること' do
          request
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to match(expected_result)
        end
      end

      context 'ロト結果が存在しない場合' do
        let(:kind) { kind_miniloto }
        let(:expected_result) { { 'results' => [] } }

        it '200が返却されること' do
          request
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq(expected_result)
        end
      end
    end

    context '存在しないロト種別の場合' do
      let(:kind) { 99 }

      it '404が返却されること' do
        request
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
