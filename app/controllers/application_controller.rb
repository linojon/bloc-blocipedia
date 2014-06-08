class ApplicationController < ActionController::Base

  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :error

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def after_sign_in_path_for(resource)
    wikis_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  private

  def user_not_authorized(exception)
    redirect_to( (request.referrer||root_url), error: "Action not authorized")
  end

  def record_not_found
    redirect_to request.referrer||root_url, error: "Page not found"
  end
end
