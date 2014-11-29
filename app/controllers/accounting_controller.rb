class AccountingController < ApplicationController

  before_filter :authenticate_account!
  respond_to :html, :js

  def index
    sql_record = "
        SELECT incomes.name, incomes.income AS record, incomes.created_at, incomes.updated_at,
        incomes.record_type, income_categories.name AS Category
        FROM incomes
        INNER JOIN
        income_categories
        ON incomes.income_category_id = income_categories.id
        WHERE incomes.account_id = #{current_account.id}
        UNION
        SELECT expenses.name, expenses.expense AS record, expenses.created_at, expenses.updated_at,
        expenses.record_type, expense_categories.name AS Category
        FROM expenses
        INNER JOIN
        expense_categories
        ON expenses.expense_category_id = expense_categories.id
        WHERE expenses.account_id = #{current_account.id}
        ORDER BY updated_at DESC"
    @records = Account.paginate_by_sql(sql_record, page: params[:page], per_page: 15)
    @total_incomes = Income.where("account_id = #{current_account.id}").sum(:income)
    @total_expenses = Expense.where("account_id = #{current_account.id}").sum(:expense)
  end

end