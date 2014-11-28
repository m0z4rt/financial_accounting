class Income < ActiveRecord::Base
  belongs_to :account
  belongs_to :income_category

  validates :name, presence: true
  validates :income, presence: true,
            numericality: true,
            format: { :with => /\A\d{1,8}(\.\d{0,2})?\z/ }
end