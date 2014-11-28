class ExpenseCategoriesController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    @expense_categories = ExpenseCategory.where("account_id = #{current_account.id}")
  end

  def show
    @expense_category = ExpenseCategory.find(params[:id])
  end

  def new
    @expense_category = ExpenseCategory.new
    @expense_category.account_id = current_account.id
  end

  def create
    @expense_categories = ExpenseCategory.where("account_id = #{current_account.id}")
    @expense_category = ExpenseCategory.create(expense_category_params)
  end

  def edit
    @expense_category = ExpenseCategory.find(params[:id])
  end

  def update
    @expense_categories = ExpenseCategory.where("account_id = #{current_account.id}")
    @expense_category = ExpenseCategory.find(params[:id])
    @expense_category.update_attributes(expense_category_params)
  end

  def delete
    @expense_category = ExpenseCategory.find(params[:expense_category_id])
  end

  def destroy
    @expense_categories = ExpenseCategory.where("account_id = #{current_account.id}")
    @expense_category = ExpenseCategory.find(params[:id])
    @expense_category.destroy
  end

  private
  def expense_category_params
    params.require(:expense_category).permit(:name, :account_id)
  end

end
