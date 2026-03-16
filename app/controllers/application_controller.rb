class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

 helper_method :admin?

  def admin?
    # Adjust this logic based on how you identify admins (e.g., a boolean column)
    current_user&.admin? 
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
