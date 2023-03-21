class CategoryController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def new
    @category = Group.new
  end

  def create
    @category = Group.new(category_params.merge(author_id: current_user.id))

    if @category.save!
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:group).permit(:name, :icon)
  end
end
