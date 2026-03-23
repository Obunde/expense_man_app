# app/controllers/budgets_controller.rb
class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: [:edit, :update]
  before_action :prevent_guest_modification, only: [:new, :edit, :create, :update]

  def index
    @budgets = current_user.budgets.order(year: :desc, month: :desc)
    @budget = current_user.budgets.build
  end

  def create
    @budget = current_user.budgets.build(budget_params)
    if @budget.save
      redirect_to budgets_path, notice: "Budget set successfully"
    else
      @budgets = current_user.budgets.order(year: :desc, month: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def new
    redirect_to budgets_path
  end
  def edit
  end

  def update
    if @budget.update(budget_params)
      redirect_to budgets_path, notice: "Budget updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:monthly_limit, :month, :year)
  end
end