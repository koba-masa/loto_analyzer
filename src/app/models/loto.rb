# frozen_string_literal: true

class Loto < ApplicationRecord
  has_many :loto_prizes, dependent: :destroy
  has_many :loto_numbers, dependent: :destroy

  enum :kinds, { loto6: 1, loto7: 2, mini_loto: 3 }

  validates :kind, presence: true, inclusion: { in: Loto.kinds.values }, uniqueness: { scope: [:times] }
  validates :times, presence: true
  validates :lottery_date, presence: true
end
