class AccountingController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    @records = Record.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

end