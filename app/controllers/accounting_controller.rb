class AccountingController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    sql_record = "
        SELECT expenses.name, expenses.expense AS record, expenses.created_at, expenses.updated_at, expense_categories.category_type
        FROM expenses, expense_categories
        WHERE expenses.account_id = #{current_account.id}
        UNION
        SELECT incomes.name, incomes.income, incomes.created_at, incomes.updated_at, income_categories.category_type
        FROM incomes, income_categories
        WHERE incomes.account_id = #{current_account.id}
        ORDER BY updated_at DESC"
    @records = Account.paginate_by_sql(sql_record, page: params[:page], per_page: 15)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

end