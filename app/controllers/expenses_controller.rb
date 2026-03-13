# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:edit, :update, :destroy]

  def index
    @expenses = current_user.expenses.includes(:category).order(expense_date: :desc)
    @expenses = @expenses.where(category_id: params[:category_id]) if params[:category_id].present?
    @expenses = @expenses.where(expense_date: params[:date]) if params[:date].present?
    @categories = current_user.categories
  end

  def new
    @expense = current_user.expenses.build
    @categories = current_user.categories
  end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_path, notice: "Expense added successfully"
    else
      @categories = current_user.categories
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = current_user.categories
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: "Expense updated successfully"
    else
      @categories = current_user.categories
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, notice: "Expense deleted successfully"
  end

  private

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:title, :amount, :expense_date, :category_id)
  end
end