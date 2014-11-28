class AccountingController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    sql_record = "
        SELECT expenses.name, expenses.expense AS record, expenses.created_at, expenses.updated_at, expenses.expense_category_id AS category_id
        FROM expenses
        WHERE expenses.account_id = #{current_account.id}
        UNION
        SELECT incomes.name, incomes.income, incomes.created_at, incomes.updated_at, incomes.income_category_id
        FROM incomes
        WHERE incomes.account_id = #{current_account.id}
        ORDER BY updated_at DESC"
    @records = Account.paginate_by_sql(sql_record, page: params[:page], per_page: 15)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

end