# frozen_string_literal: true

class Loto < ApplicationRecord
  has_many :loto_prizes, dependent: :destroy
  has_many :loto_numbers, dependent: :destroy

  enum :kinds, { loto6: 6, loto7: 7, mini_loto: 5 }

  validates :kind, presence: true, inclusion: { in: Loto.kinds.values }, uniqueness: { scope: [:times] }
  validates :times, presence: true
  validates :lottery_date, presence: true

  default_scope { order(times: :asc) }
end
