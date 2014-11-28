class CreateIncomeCategories < ActiveRecord::Migration
  def change
    create_table :income_categories do |t|
      t.string :name
      t.references :account, index: true

      t.timestamps
    end
  end
end
