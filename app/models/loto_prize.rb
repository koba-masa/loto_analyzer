# frozen_string_literal: true

class LotoPrize < ApplicationRecord
  belongs_to :loto

  validates :grade, presence: true, numericality: { greater_than: 0 }
  validates :winning_number, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :winning_aoumnt, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  default_scope { order(grade: :asc) }
end
