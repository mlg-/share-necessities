class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).concat [:first_name, :last_name, :bio, :profile_photo]
    devise_parameter_sanitizer.for(:account_update).concat [:first_name, :last_name, :bio, :profile_photo]
    devise_parameter_sanitizer.for(:invite).concat [:first_name, :last_name, :invited_by_organization_id]
    devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name]
  end
end
