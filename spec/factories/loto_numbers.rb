# frozen_string_literal: true

FactoryBot.define do
  factory :loto_number do
    loto { build(:loto) }
    is_not_bonus
    number { 14 }

    trait :is_bonus do
      is_bonus { true }
    end

    trait :is_not_bonus do
      is_bonus { false }
    end
  end
end
