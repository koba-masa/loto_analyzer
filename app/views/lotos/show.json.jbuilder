# frozen_string_literal: true

json.results @lotos do |loto|
  json.kind loto.kind
  json.lottery_date loto.lottery_date.strftime('%Y/%m/%d')
  json.sales_amount loto.sales_amount
  json.loto_numbers loto.loto_numbers.unbouns.map(&:number)
  json.bounus_loto_number loto.loto_numbers.bouns[0].number
end
