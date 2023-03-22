class CategoryController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group
      .select('groups.*, users.name AS username, SUM(expenses.amount) AS total_amount')
      .left_joins(:user, :expenses)
      .where(user: current_user)
      .group('groups.id, users.id')
  end

  def new
    @category = Group.new
  end

  def create
    @category = Group.new(category_params.merge(user: current_user))
    authorize! :create, @category

    if @category.save!
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    category = Group.find(params[:category_id])
    authorize! :delete, category

    if category.destroy
      redirect_to categories_path
    else
      redirect_to categories_path, status: :bad_request
    end
  end

  private

  def category_params
    params.require(:group).permit(:name, :icon)
  end
end
