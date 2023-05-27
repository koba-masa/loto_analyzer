# frozen_string_literal: true

FactoryBot.define do
  factory :loto do
    kind { Loto.kinds[:loto6] }
    sequence(:times, 1) { |n| n }
    lottery_date { Date.new(2023, 1, 1) }
    sales_amount { 557_729_800 }
  end
end
