class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  add_flash_types :error, :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  protected

  def authorize
    redirect_to login_path unless current_user
  end
end
