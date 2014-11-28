class AddTypeToExpenseCategories < ActiveRecord::Migration
  def change
    add_column :expense_categories, :type, :string
  end
end
