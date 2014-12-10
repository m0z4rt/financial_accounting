class AccountingController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    search_start_date = params[:search_start_date]
    search_end_date = params[:search_end_date]
    if params[:search]
      @records = Record.search(params[:search]).where("DATE(updated_at) >= ? AND DATE(updated_at) <= ?",
          search_start_date, search_end_date).order("updated_at DESC").paginate(page: params[:page], per_page: 15)
    else
      @records = Record.where(
          "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15)
    end
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
    @start_date = Record.where("account_id = #{current_account.id}").minimum(:updated_at).strftime("%Y-%m-%d")
    @end_date = Record.where("account_id = #{current_account.id}").maximum(:updated_at).strftime("%Y-%m-%d")
  end

end