require 'application_responder'

# ApplicationController
class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message
  end

  check_authorization unless: :devise_controller?

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
