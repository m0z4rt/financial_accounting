class Record < ActiveRecord::Base
  self.table_name = 'incomes_expenses_view'

  belongs_to :account
end