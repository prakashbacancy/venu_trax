class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :venue_contact_permissions, if: :user_venue_contact?
  around_action :set_time_zone
  layout :layout_by_resource

  # Separate layout for pages `before login` and pages `after login`
  def layout_by_resource
    if devise_controller?
      'registration'
    else
      'application'
    end
  end



  def set_time_zone
    if user_signed_in?
      Time.use_zone(current_user.time_zone) { yield }
    else
      yield
    end
  end

  # Conditional URL after login
  def after_sign_in_path_for(_resource)
    if user_signed_in? && (current_user.try(:contact) == 'venue_contact')
      venue_path(current_user.venue_contacts.first.venue)
    else
      root_path
    end
  end

  protected

  # Check `current_user` contact to apply or revoke permissions
  def user_venue_contact?
    current_user.try(:contact) == 'venue_contact'
  end

  # TODO: Use better way for Venue Contacts permissions
  def venue_contact_permissions
    if controller_name == 'venues'
      return unless %w[index].include?(action_name)
    else
      not_permitted_controllers = %w[businesses brands settings]
      return unless not_permitted_controllers.include?(controller_name)
    end
    redirect_to venue_path(current_user.venue_contacts.first.venue)
  end

  # Modify existing Devise Parameters
  def configure_permitted_parameters
    dynamic_params = Klass.user.fields.pluck(:name)
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :phone_no, :profile_pic] + dynamic_params)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :phone_no, :profile_pic] + dynamic_params)
  end
end
