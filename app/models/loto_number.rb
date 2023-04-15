# frozen_string_literal: true

class LotoNumber < ApplicationRecord
  belongs_to :loto

  validates :is_bonus, inclusion: [true, false]
  validates :number, presence: true, numericality: { greater_than: 0 }, uniqueness: { scope: [:loto] }
end
