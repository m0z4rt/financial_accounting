class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.decimal :expense, precision: 12, scale: 2
      t.references :account, index: true
      t.references :expense_category, index: true

      t.timestamps
    end
  end
end
