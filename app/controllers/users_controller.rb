class UsersController < ApplicationController
  layout "layouts/users", except: [:new, :index]
  layout "layouts/application", only: [:new, :index]

  before_action :signed_in_user, only: [:show, :calendar, :edit, :update]
  before_action :correct_user,   only: [:edit, :calendar, :update]

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
    oldStatus = @user.status
    @user.update_attributes(user_params)
    if @user.save
      redirect_to update_usernames_path(@user.username)
    else
      flash.now[:danger] = "Error: Failed to update status"
      @user.update_attribute(:status, oldStatus)
      render 'show'
    end
  end

  def calendar
    @user = User.find_by_username(params[:username])
    @activities = @user.activities
    @date = params[:date] ? Date.strptime(params[:date], "%Y-%m") : Date.today
    @month = @date.strftime("%B")
    @year = @date.strftime("%Y")
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit( :fname, :lname, :username, :email, :password, :password_confirmation, :gender, :birthdate, :height, :weight, :status)
  end

  def signed_in_user
    unless signed_in?
      flash[:danger] = "Sign in to access this page"
      store_location
      redirect_to signin_path
    end
  end

  def correct_user
    @user = User.find_by_username(params[:username])
    redirect_to(root_path) unless current_user?(@user)
  end
end
