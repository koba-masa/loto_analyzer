# frozen_string_literal: true

FactoryBot.define do
  factory :loto_prize do
    loto { build(:loto) }
    grade { 1 }
    winning_number { 14 }
    winning_aoumnt { 11_965_900 }
  end
end
