class CreateRecordsView < ActiveRecord::Migration
  def change
    execute <<-SQL
    CREATE OR REPLACE VIEW records AS
    SELECT incomes.id as record_id, incomes.name, incomes.income AS record, incomes.account_id,
    incomes.created_at, incomes.updated_at, incomes.record_type, income_categories.name AS Category
    FROM incomes
    LEFT OUTER JOIN
    income_categories
    ON incomes.income_category_id = income_categories.id
    UNION
    SELECT expenses.id  as record_id, expenses.name, expenses.expense AS record, expenses.account_id,
    expenses.created_at, expenses.updated_at, expenses.record_type, expense_categories.name AS Category
    FROM expenses
    LEFT OUTER JOIN
    expense_categories
    ON expenses.expense_category_id = expense_categories.id
    ORDER BY updated_at DESC
    SQL
  end
end
