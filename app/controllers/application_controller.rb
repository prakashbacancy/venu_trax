class ApplicationController < ActionController::Base
  before_action :authenticate_user!
	layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      'registration'
    else
      'application'
    end
  end
end
