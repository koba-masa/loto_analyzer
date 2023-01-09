# frozen_string_literal: true

class Loto < ApplicationRecord
  enum :types, { loto6: 1, loto7: 2, mini_loto: 3 }

  validates :type, presence: true, inclusion: { in: Loto.types.values }, uniqueness: { scope: [:times] }
  validates :times, presence: true
  validates :lottery_date, presence: true
end
