class UsersController < ApplicationController
  skip_before_action :authorize

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.save ? (redirect_to users_url) : (render 'new')
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role, :term)
  end
end
