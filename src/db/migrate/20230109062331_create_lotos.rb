# frozen_string_literal: true

class CreateLotos < ActiveRecord::Migration[7.0]
  def change
    create_table :lotos do |t|
      t.integer :type, null: false, comment: '種別'
      t.integer :times, null: false, comment: '開催回'
      t.date :lottery_date, null: false, comment: '抽選日'
      t.integer :sales_amount, null: true, comment: '販売実績額'
      t.timestamps
    end

    add_index :lotos, %i[type times], unique: true
  end
end
