class AddColumnsToRecords < ActiveRecord::Migration
  def change
    add_column :incomes, :record_type, :string
    add_column :expenses, :record_type, :string
  end
end
