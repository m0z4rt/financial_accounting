class RenameColumnType < ActiveRecord::Migration
  def change
    rename_column :expense_categories, :type, :category_type
  end
end
