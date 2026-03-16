# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    # Removed the 'where(admin: false)' so admins can manage everyone
    @users = User.order(created_at: :desc)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # If password field is blank, don't try to update it
    params_to_use = user_params.to_h
    if params_to_use[:password].blank?
      params_to_use.delete(:password)
      params_to_use.delete(:password_confirmation)
    end

    if @user.update(params_to_use)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    redirect_to root_path, alert: "Not authorized" unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end