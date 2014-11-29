class ExpensesController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    @expenses = Expense.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15).order('updated_at DESC')
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
    @expense.account_id = current_account.id
  end

  def create
    @expenses = Expense.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15).order('updated_at DESC')
    @expense = Expense.create(expense_params)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expenses = Expense.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15).order('updated_at DESC')
    @expense = Expense.find(params[:id])
    @expense.update_attributes(expense_params)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  def delete
    @expense = Expense.find(params[:expense_id])
  end

  def destroy
    @expenses = Expense.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15).order('updated_at DESC')
    @expense = Expense.find(params[:id])
    @expense.destroy
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

  private
  def expense_params
    params.require(:expense).permit(:name, :expense, :account_id, :expense_category_id, :record_type)
  end

end