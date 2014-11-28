class IncomesController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    @incomes = Income.where("account_id = #{current_account.id}")
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
  end

  def show
    @income = Income.find(params[:id])
  end

  def new
    @income = Income.new
    @income.account_id = current_account.id
  end

  def create
    @incomes = Income.where("account_id = #{current_account.id}")
    @income = Income.create(income_params)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
  end

  def edit
    @income = Income.find(params[:id])
  end

  def update
    @incomes = Income.where("account_id = #{current_account.id}")
    @income = Income.find(params[:id])
    @income.update_attributes(income_params)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
  end

  def delete
    @income = Income.find(params[:income_id])
  end

  def destroy
    @incomes = Income.where("account_id = #{current_account.id}")
    @income = Income.find(params[:id])
    @income.destroy
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
  end

  private
  def income_params
    params.require(:income).permit(:name, :income, :account_id, :income_category_id)
  end

end