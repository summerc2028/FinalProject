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
      sign_in @user, false
      redirect_to usernames_path(@user.username)
    else
      render 'new'
    end
  end

  def update
    @user = User.find_by_id(params[:username])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to update_usernames_path(@user.username)
    else
      flash.now[:danger] = "Error: Failed to update status"
      render 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit( :fname, :lname, :username, :email, :password, :password_confirmation, :gender, :birthdate, :height, :weight, :status)
  end

end
