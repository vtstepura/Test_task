module Admin
  class UsersController < Admin::BaseController
    def new
      @user = User.new
    end

    def index
      @users = User.search(params[:term]).paginate(page: params[:page], per_page: 3)
    end

    def show
      user
    end

    def edit
      user
    end

    def update
      if user.update(user_params)
        redirect_to admin_users_path, success: 'Account was update!'
      else
        render 'edit', error: 'Account wasn`t update!'
      end
    end

    def destroy
      user.destroy
      redirect_to admin_users_path, success: 'User was deleted!'
    end

    private

    def user
      @user ||= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :role, :term)
    end
  end
end
