class IncomeCategoriesController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    @income_categories = IncomeCategory.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15).order('updated_at DESC')
  end

  def show
    @income_category = IncomeCategory.find(params[:id])
  end

  def new
    @income_category = IncomeCategory.new
    @income_category.account_id = current_account.id
  end

  def create
    @income_categories = IncomeCategory.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15).order('updated_at DESC')
    @income_category = IncomeCategory.create(income_category_params)
  end

  def edit
    @income_category = IncomeCategory.find(params[:id])
  end

  def update
    @income_categories = IncomeCategory.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15).order('updated_at DESC')
    @income_category = IncomeCategory.find(params[:id])
    @income_category.update_attributes(income_category_params)
  end

  def delete
    @income_category = IncomeCategory.find(params[:income_category_id])
  end

  def destroy
    @income_categories = IncomeCategory.where(
        "account_id = #{current_account.id}").paginate(page: params[:page], per_page: 15).order('updated_at DESC')
    @income_category = IncomeCategory.find(params[:id])
    @income_category.destroy
  end

  private
  def income_category_params
    params.require(:income_category).permit(:name, :account_id)
  end

end