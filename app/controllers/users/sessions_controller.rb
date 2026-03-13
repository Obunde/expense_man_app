# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_users_path
    else
      authenticated_root_path
    end
  end
end