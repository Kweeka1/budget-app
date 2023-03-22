module ExpensesHelper
  def sum_amounts(expenses)
    amount = 0
    expenses.each { |expense| amount += expense.amount }
    amount
  end
end
