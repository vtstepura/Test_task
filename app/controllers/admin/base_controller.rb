module Admin
  class BaseController < ApplicationController
    before_action :redirect_user

    def redirect_user
      redirect_to root_path unless current_user.admin?
    end
  end
end
