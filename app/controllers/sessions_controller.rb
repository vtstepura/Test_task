class SessionsController < ApplicationController
  skip_before_action :authorize

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to(user.admin? ? admin_users_path : users_path)
    else
      redirect_to login_path, error: 'Check your email and password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
