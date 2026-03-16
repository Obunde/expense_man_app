require 'rails_helper'

RSpec.describe "Categories CRUD", type: :system do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  it "allows a user to manage categories" do
    # CREATE
    visit categories_path
    fill_in "Category name", with: "Business Trip"
    click_button "Create Category"
    expect(page).to have_content "Category added successfully"

    # READ
    expect(page).to have_content "Business Trip"

    # DELETE
    accept_confirm do
      click_link "Delete", match: :first
    end
    expect(page).to have_content "Category deleted successfully"
  end
end