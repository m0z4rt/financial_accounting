class Expense < ActiveRecord::Base
  belongs_to :account
  belongs_to :expense_category

  validates :name, presence: true
  validates :expense, presence: true,
            numericality: true,
            format: { :with => /\A\d{1,8}(\.\d{0,2})?\z/ }
end