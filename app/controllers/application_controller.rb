class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
	layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      'registration'
    else
      'application'
    end
  end

  protected

  def configure_permitted_parameters
    dynamic_params = Klass.user.fields.pluck(:name)
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :phone_no, :profile_pic] + dynamic_params)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :phone_no, :profile_pic] + dynamic_params)
  end
end
