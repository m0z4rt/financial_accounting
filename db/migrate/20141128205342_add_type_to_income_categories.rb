class AddTypeToIncomeCategories < ActiveRecord::Migration
  def change
    add_column :income_categories, :type, :string
  end
end
