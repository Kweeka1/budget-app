class ExpensesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @expenses = Group.find(params[:category_id]).expenses.includes(:user).order(created_at: :desc)
    @group_id = params[:category_id]
  end

  def new
    @expense = Expense.new
    @groups = Group.select('groups.name').where(user: current_user).pluck(:name)
    @group_id = params[:category_id]
  end

  def create
    @expense = Expense.new(expense_params.merge(user: current_user))
    @expense.groups << Group.find_by(name: params[:category])

    if @expense.save
      redirect_to expenses_path(params[:category_id])
    else
      @groups = Group.select('groups.name').where(user: current_user).pluck(:name)
      @group_id = params[:category_id]
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    expense = Expense.find(destroy_params[:expense_id])

    if expense.destroy
      redirect_to expenses_path(destroy_params[:category_id])
    else
      redirect_to expenses_path(destroy_params[:category_id]), status: :bad_request
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :category)
  end

  def destroy_params
    params.permit(:authenticity_token, :category_id, :expense_id)
  end
end
