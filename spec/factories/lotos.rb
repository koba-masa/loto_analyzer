# frozen_string_literal: true

FactoryBot.define do
  factory :loto do
    kind { Loto.kinds[:loto6] }
    times { 10 }
    lottery_date { Date.new(2023, 0o1, 0o1) }
    sales_amount { 557_729_800 }
  end
end
