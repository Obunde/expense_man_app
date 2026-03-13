# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users = User.where(admin: false).order(created_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully"
  end

  private

  def require_admin
    redirect_to root_path, alert: "Not authorized" unless current_user.admin?
  end
end