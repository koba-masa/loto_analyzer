# frozen_string_literal: true

class CreateLotoPrizes < ActiveRecord::Migration[7.0]
  def change
    create_table :loto_prizes do |t|
      t.references :loto, comment: 'ロトID'
      t.integer :grade, null: false, comment: '等数'
      t.integer :winning_number, null: true, default: 0, comment: '当選口数'
      t.integer :winning_aoumnt, null: true, default: 0, comment: '当選額'

      t.timestamps
    end
  end
end
