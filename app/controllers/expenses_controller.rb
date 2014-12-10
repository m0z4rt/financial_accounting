class ExpensesController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
    @expense.account_id = current_account.id
  end

  def create
    @records = Record.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15)
    @expense = Expense.create(expense_params)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @records = Record.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15)
    @expense = Expense.find(params[:id])
    @expense.update_attributes(expense_params)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  def delete
    @expense = Expense.find(params[:expense_id])
  end

  def destroy
    @records = Record.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15)
    @expense = Expense.find(params[:id])
    @expense.destroy
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  private
  def expense_params
    params.require(:expense).permit(:name, :expense, :account_id, :expense_category_id, :record_type)
  end

end