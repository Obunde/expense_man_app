require 'rails_helper'

RSpec.describe "User Sessions", type: :system do
  let(:user) { create(:user, email: 'eugene@example.com', password: 'password123') }

  it "allows a user to log in and redirects to dashboard" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: 'password123'
    click_button "Log In"

    expect(page).to have_content "Signed in successfully"
    expect(current_path).to eq authenticated_root_path
  end

  it "shows an error message with invalid credentials" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: 'wrongpassword'
    click_button "Log In"

    expect(page).to have_content "Invalid email or password."
  end
end