class IncomesController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def show
    @income = Income.find(params[:id])
  end

  def new
    @income = Income.new
    @income.account_id = current_account.id
  end

  def create
    @records = Record.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15)
    @income = Income.create(income_params)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  def edit
    @income = Income.find(params[:id])
  end

  def update
    @records = Record.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15)
    @income = Income.find(params[:id])
    @income.update_attributes(income_params)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  def delete
    @income = Income.find(params[:income_id])
  end

  def destroy
    @records = Record.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15)
    @income = Income.find(params[:id])
    @income.destroy
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  private
  def income_params
    params.require(:income).permit(:name, :income, :account_id, :income_category_id, :record_type)
  end

end