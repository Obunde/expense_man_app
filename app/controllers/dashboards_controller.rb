# app/controllers/dashboards_controller.rb
class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @total_spending = current_user.expenses
                        .where(expense_date: Date.current.beginning_of_month..Date.current.end_of_month)
                        .sum(:amount)
    @budget = current_user.budgets.find_by(month: Date.current.month, year: Date.current.year)
    @recent_expenses = current_user.expenses.includes(:category).order(expense_date: :desc).limit(5)
  end
end