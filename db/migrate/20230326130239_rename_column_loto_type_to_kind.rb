# frozen_string_literal: true

class RenameColumnLotoTypeToKind < ActiveRecord::Migration[7.0]
  def up
    rename_column :lotos, :type, :kind
  end

  def down
    rename_column :lotos, :kind, :type
  end
end
