class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :name
      t.decimal :income, precision: 12, scale: 2
      t.references :account, index: true
      t.references :income_category, index: true

      t.timestamps
    end
  end
end
