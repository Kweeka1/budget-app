class ExpensesController < ApplicationController
  before_action :authenticate_user!

  def index
    @expenses_groups = Expenses.includes(:groups).where(groups: { id: params[:category_id] })
    puts @expenses_groups
  end

  def show
  end
end
