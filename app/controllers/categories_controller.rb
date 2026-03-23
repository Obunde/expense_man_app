# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :prevent_guest_modification, only: [:create, :destroy]

  def index
    @categories = current_user.categories.order(created_at: :desc)
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category added successfully"
    else
      @categories = current_user.categories
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "Category deleted successfully"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end