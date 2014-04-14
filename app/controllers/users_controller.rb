class UsersController < ApplicationController
  layout "layouts/users", except: [:new, :create, :index]
  layout "layouts/application", only: [:new, :create, :index]

  before_action :signed_in_user, except: [:new, :create]
  before_action :correct_user,   except: [:new, :create, :show, :index]
  before_action :admin, only: [:index]

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_username(params[:username])
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @day_activities = @user.activities.select { |x| x.day.eql? @date }
  end

  def show_day
    @user = User.find_by_username(params[:username])
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @day_activities = @user.activities.select { |x| x.day.eql? @date }
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

  def update_status
    @user = User.find_by_username(params[:username])
    @user.update_attributes(status_params)
    if @user.save
      redirect_to usernames_path(@user.username)
    else
      flash.now[:danger] = "Error: Failed to update status"
      render 'show'
    end
  end

  def update
    @user = User.find_by_username(params[:username])
    @user.update_attributes(update_params)
    if @user.save
      flash[:success] = "Profile Successfully Updated!"
      redirect_to usernames_path(@user.username)
    else
      flash.now[:danger] = "Error: Failed to update profile"
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

    def status_params
      params.permit :status
    end

    def update_params
      params.permit :fname, :lname, :gender, :birthdate, :height, :weight
    end

    def signed_in_user
      unless signed_in?
        flash[:danger] = "Sign in to access this page"
        store_location
        redirect_to signin_path
      end
    end

    def correct_user
      @user = User.find_by_username params[:username]
      unless current_user? @user
        flash[:danger] = "You don't have permission to do that!"
        redirect_to usernames_path(params[:username])
      end
    end

    def admin
      unless current_user.admin
        flash[:danger] = "You don't have permission to do that!"
        redirect_to usernames_path(current_user.username)
      end
    end
end
