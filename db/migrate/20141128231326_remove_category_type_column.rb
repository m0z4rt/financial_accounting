class RemoveCategoryTypeColumn < ActiveRecord::Migration
  def change
    remove_column :expense_categories, :category_type
    remove_column :income_categories, :category_type
  end
end
