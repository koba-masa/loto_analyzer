# frozen_string_literal: true

class CreateLotoNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :loto_numbers do |t|
      t.references :loto, comment: 'ロトID'
      t.boolean :is_bonus, null: false, defalut: false, comment: 'ボーナス数字'
      t.integer :number, null: false, comment: '数字'

      t.timestamps
    end

    add_index :loto_numbers, %i[loto_id number], unique: true
  end
end
