class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  layout :layout

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || users_show_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthdate,:first_name,:last_name,:currency_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:birthdate,:first_name,:last_name,:currency_id])
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def layout
    # only turn it off for devise pages:
    if devise_controller?
      false
    else
      "application"
    end
  end

end
