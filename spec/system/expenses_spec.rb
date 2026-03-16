require 'rails_helper'

RSpec.describe "Expenses CRUD", type: :system do
  let(:user) { create(:user) }
  let!(:category) { create(:category, user: user, name: "Transport") }

  before do
    login_as(user, scope: :user) # Devise helper
  end

  it "allows a user to create, update, and delete an expense" do
    # CREATE
    visit new_expense_path
    fill_in "Title", with: "Matatu to Juja"
    fill_in "Amount", with: 100
    fill_in "Date", with: Date.current
    select "Transport", from: "Category"
    click_button "Create Expense"
    expect(page).to have_content "Expense added successfully"

    # UPDATE
    click_link "Edit"
    fill_in "Amount", with: 150
    click_button "Update Expense"
    expect(page).to have_content "Expense updated successfully"

    # DELETE
    # Note: If using Turbo/Hotwire, ensure your test driver supports JS for the confirm dialog
    accept_confirm do
      click_link "Delete"
    end
    expect(page).to have_content "Expense deleted successfully"
  end
end