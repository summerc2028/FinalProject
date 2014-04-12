class ActivityController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def index
  end

  def authenticate
    flash.now[:danger] = 'Cannot Add Activity, Please Sign In!'
    redirect_to("/signin") if current_user.nil?
  end

  def correct_user
    @user = User.find_by_username(params[:username])
    redirect_to(root_path) unless current_user?(@user)
  end

end
