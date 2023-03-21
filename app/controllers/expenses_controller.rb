class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenses = Group.find(params[:category_id]).expenses.order(created_at: :desc)
    @group_id = params[:category_id]
  end

  def new
    @expense = Expense.new
  end

  def create
    expense = Expense.new(expense_params.merge(user: current_user))
    expense.groups << Group.find(params[:category_id])

    if expense.save
      redirect_to expenses_path(params[:category_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    expense = Expense.find(destroy_params[:expense_id])

    if expense.destroy
      redirect_to expenses_path(destroy_params[:category_id]), status: :accepted
    else
      redirect_to expenses_path(destroy_params[:category_id]), status: :bad_request
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end

  def destroy_params
    params.permit(:authenticity_token, :category_id, :expense_id)
  end
end
