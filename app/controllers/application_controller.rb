class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

 helper_method :admin?

  def admin?
    # Adjust this logic based on how you identify admins (e.g., a boolean column)
    current_user&.admin? 
  end

  def current_user
    super || (session[:demo_mode] ? Guest.new : nil)
  end

  def authenticate_user!(opts = {})
    if session[:demo_mode]
      # Guest is "authenticated" for viewing purposes
      return true
    end
    super
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private
  def prevent_guest_modification
    if current_user.guest?
      redirect_back fallback_location: root_path, alert: "Guests cannot modify data."
    end
  end
end
