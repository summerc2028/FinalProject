class UsersController < ApplicationController
  layout "layouts/users", except: [:new, :create, :index]
  layout "layouts/application", only: [:new, :create, :index]

  before_action :signed_in_user, except: [:new, :create]
  before_action :correct_user,   except: [:new, :create, :show, :index]
  before_action :admin, only: [:index]

  # Generates new user form
  def new
    @user = User.new
  end

  # Supplies information to display user
  def show
    @user = User.find_by_username(params[:username])
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @day_activities = @user.activities.select { |x| x.day.eql? @date }
    @day_foods = @user.foods.select { |x| x.day.eql? @date }
    @day_exercises = @user.exercises.select { |x| x.day.eql? @date }
  end

  # Supplies information to display user information related to the current day
  def show_day
    @user = User.find_by_username(params[:username])
    @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
    @day_activities = @user.activities.select { |x| x.day.eql? @date }
  end

  #Creates a new user
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

  # Update the status pannel in user profile
  def update_status
    @user = User.find_by_username(params[:username])
    @user.update_attributes(status_params)
    if @user.save
      redirect_to usernames_path(@user.username)
    else
      flash[:danger] = "Error: Failed to update status"
      @day_activities = @user.activities.select { |x| x.day.eql? @date }
      @day_foods = @user.foods.select { |x| x.day.eql? @date }
      @day_exercises = @user.exercises.select { |x| x.day.eql? @date }
      render 'show'
    end
  end

  #Updates user information in database
  def update
    @user = User.find_by_username(params[:username])
    @user.update_attributes(update_params)
    if @user.save
      flash[:success] = "Profile Successfully Updated!"
      redirect_to usernames_path(@user.username)
    else
      @day_activities = @user.activities.select { |x| x.day.eql? @date }
      @day_foods = @user.foods.select { |x| x.day.eql? @date }
      @day_exercises = @user.exercises.select { |x| x.day.eql? @date }
      flash.now[:danger] = "Error: Failed to update profile"
      render 'show'
    end
  end

  # Supply required information for calendar page
  def calendar
    @user = User.find_by_username(params[:username])
    @activities = @user.activities
    @date = params[:date] ? Date.strptime(params[:date], "%Y-%m") : Date.today
    @month = @date.strftime("%B")
    @year = @date.strftime("%Y")
  end

  # Supplies required information to the exercise_food page
  def exercise_food
      @user = User.find_by_username(params[:username])
      @date = params[:date].nil? ? Date.current : Date.parse(params[:date])
      @day_foods = @user.foods.select { |x| x.day.eql? @date }
      @day_exercises = @user.exercises.select { |x| x.day.eql? @date }
      @month_exercises = @user.exercises.select { |x| x.day.strftime("%B%Y").eql? @date.strftime("%B%Y")}
   end

   # Define variable of all users
  def index
    @users = User.all
  end

  # Removes a user from database
  def destroy
    User.find_by_username(params[:username]).destroy
    redirect_to root_url
  end

  def change_password
    @user = User.find_by_username(params[:username])
    if (@user.authenticate(params[:old_password]))
      if !params[:password].empty? && @user.update_attributes(change_password_params)
        flash.now[:success] = "Password changed successfully."
      else
        flash.now[:danger] = "Error: Failed to change password"
      end
    else
      flash.now[:danger] = "Error: The old password is incorrect."
    end
    render 'settings'
  end

  private

    # Paramenters for a user form
    def user_params
      params.require(:user).permit( :fname, :lname, :username, :email, :password, :password_confirmation, :gender, :birthdate, :height, :weight, :status)
    end

    # Parameters for user status
    def status_params
      params.permit :status
    end

    # Parameters for changing password
    def change_password_params
      params.permit :password, :password_confirmation
    end

    # Parameters required to update profile 
    def update_params
      params.permit :fname, :lname, :gender, :birthdate, :height, :weight
    end

    # Redirect you if you are not signed in
    def signed_in_user
      unless signed_in?
        flash[:danger] = "Sign in to access this page"
        store_location
        redirect_to signin_path
      end
    end

    # Check the correct user is accesing information
    def correct_user
      @user = User.find_by_username params[:username]
      unless current_user? @user
        flash[:danger] = "You don't have permission to do that!"
        redirect_to usernames_path(params[:username])
      end
    end

    # Redirects you if you do not have admin privilleges
    def admin
      unless current_user.admin
        flash[:danger] = "You don't have permission to do that!"
        redirect_to usernames_path(current_user.username)
      end
    end

end
