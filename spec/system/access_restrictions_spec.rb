require 'rails_helper'

RSpec.describe "Access Restrictions", type: :system do
  let(:user_a) { create(:user, email: "usera@example.com") }
  let(:user_b) { create(:user, email: "userb@example.com") }
  let!(:expense_a) { create(:expense, user: user_a, title: "Secret Gift") }

  it "prevents User B from editing User A's expense" do
    login_as(user_b, scope: :user)

    # Attempt to visit the edit page for User A's expense directly
    visit edit_expense_path(expense_a)

    # Current behavior raises RecordNotFound because scope is current_user.expenses
    expect(page).to have_content "Couldn't find Expense"
  end

  it "prevents User B from seeing User A's expense in the list" do
    login_as(user_b, scope: :user)
    visit expenses_path
    expect(page).not_to have_content "Secret Gift"
  end
end