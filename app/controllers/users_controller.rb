class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_username(params[:username])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account Successfully Created!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit( :name, :username, :email, :password, :password_confirmation)
    end
end
