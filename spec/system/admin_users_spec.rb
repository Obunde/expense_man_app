require 'rails_helper'

RSpec.describe "Admin User Management", type: :system do
  let(:admin) { create(:user, :admin) }
  let!(:other_user) { create(:user, name: "Old Name") }

  before do
    login_as(admin, scope: :user)
  end

  it "allows an admin to manage users" do
    visit admin_users_path
    
    # READ
    expect(page).to have_content "Old Name"

    # UPDATE
    find("a[href*='edit']", match: :first).click
    fill_in "Name", with: "Updated Name"
    click_button "Update User"
    expect(page).to have_content "Updated Name"

    # CREATE NEW USER
    click_link "New User"
    fill_in "Name", with: "New Employee"
    fill_in "Email", with: "new@example.com"
    fill_in "Password", with: "password123"
    check "Grant Administrator Privileges"
    click_button "Create User"
    expect(page).to have_content "new@example.com"
    
    # DELETE
    accept_confirm do
      within("tr", text: "Updated Name") do
        click_link "Delete"
      end
    end
    expect(page).not_to have_content "Updated Name"
  end
end