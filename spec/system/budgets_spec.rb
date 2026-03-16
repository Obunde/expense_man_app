require 'rails_helper'

RSpec.describe "Budgets CRUD", type: :system do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  it "allows a user to set and adjust monthly budgets" do
    # CREATE
    visit budgets_path
    fill_in "budget_monthly_limit", with: 25000
    select "March", from: "budget_month"
    fill_in "budget_year", with: 2026
    click_button "Set Budget"
    expect(page).to have_content "Budget set successfully"

    # UNSUCCESSFUL CREATE (Duplicate)
    visit budgets_path
    fill_in "budget_monthly_limit", with: 10000
    select "March", from: "budget_month"
    fill_in "budget_year", with: 2026
    click_button "Set Budget"
    expect(page).to have_content "already has a budget for this month"

    # UPDATE
    visit budgets_path
    click_link "Edit", match: :first
    fill_in "budget_monthly_limit", with: 30000
    click_button "Update Budget"
    expect(page).to have_content "Budget updated successfully"
  end
end