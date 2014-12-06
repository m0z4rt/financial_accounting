class ExpenseCategory < ActiveRecord::Base
  belongs_to :account
  has_many :expenses, :dependent => :destroy
  validates :name, presence: true
end