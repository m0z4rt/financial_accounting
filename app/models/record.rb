class Record < ActiveRecord::Base
  self.table_name = 'incomes_expenses_view'
  belongs_to :account

  def self.search(query)
    where("name LIKE ? OR category LIKE ?",
          "%#{query}%", "%#{query}%")
  end
end