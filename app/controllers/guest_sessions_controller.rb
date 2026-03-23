# app/controllers/guest_sessions_controller.rb
class GuestSessionsController < ApplicationController
  # This is crucial so Devise doesn't block the "Try as Guest" click
  skip_before_action :authenticate_user!, only: [:create], raise: false

  def create
    session[:demo_mode] = true
    # This leads to dashboard#index as defined in your routes
    redirect_to dashboards_path, notice: "Welcome to SpendLess Demo!"
  end

  def destroy
    session[:demo_mode] = nil
    redirect_to root_path, notice: "Signed out of Demo Mode."
  end
end