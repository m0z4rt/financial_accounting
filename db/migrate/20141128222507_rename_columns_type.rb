class RenameColumnsType < ActiveRecord::Migration
  def change
	rename_column :income_categories, :type, :category_type
  end
end
