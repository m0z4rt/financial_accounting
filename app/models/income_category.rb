class IncomeCategory < ActiveRecord::Base
  belongs_to :account
  has_many :incomes, :dependent => :destroy
  validates :name, presence: true
end