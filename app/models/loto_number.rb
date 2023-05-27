# frozen_string_literal: true

class LotoNumber < ApplicationRecord
  belongs_to :loto

  validates :is_bonus, inclusion: [true, false]
  validates :number, presence: true, numericality: { greater_than: 0 }, uniqueness: { scope: [:loto] }

  default_scope { order(number: :asc) }
  scope :bouns, -> { where(is_bonus: true) }
  scope :unbouns, -> { where(is_bonus: false) }
end
