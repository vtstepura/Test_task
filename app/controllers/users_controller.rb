class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[new create]
  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.save ? (redirect_to users_url) : (render 'new')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.update(user_params) ? (redirect_to users_url) : (render 'edit')
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role, :term)
  end
end
