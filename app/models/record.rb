class Record < ActiveRecord::Base
  self.table_name = 'incomes_expenses_view'

  belongs_to :account

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    end
  end
end