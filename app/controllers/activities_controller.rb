class ActivitiesController < ApplicationController
  layout "layouts/users"
  # Checks correct user and authenticates 
  before_filter :authenticate
  before_filter :correct_user
  
  # Generates new Activity form
  def new
    @activity = Activity.new
  end

  #Creates a new activity
  def create
    # Obtain user information by searching for username
    @user = User.find_by_username(params[:username])
    @activity = @user.activities.new(activity_params)
    if @activity.save
      flash[:success] = "Activity Successfully Added!"
      redirect_to calendar_path(@user.username)
    else
      render 'new'
    end
  end

  # Supplies information to display activities
  def show
    @user = User.find_by_username(params[:username])
    @activity = Activity.find params[:id]
    unless @user.activities.include? @activity
      flash[:danger] = "Error: Invalid activity"
      redirect_to usernames_path(params[:username])
    end
  end

  # Removes an activity from database
  def destroy
    @user = User.find_by_username(params[:username])
    @activity = Activity.find params[:id]
    unless @user.activities.include? @activity
      flash[:danger] = "Error: Invalid activity"
      redirect_to usernames_path(params[:username])
    else
      @activity.destroy
      redirect_to usernames_path(@user.username)
    end
  end

  #Updates activity in database
  def update
    @activity = Activity.find_by_id(params[:id])
    @activity.update_attributes(activity_params)
    if @activity.save
      flash[:success] = "Activity Successfully Updated!"
      redirect_to show_activity_path(username: @user.username, id: @activity.id)
    else
      flash.now[:danger] = "Error: Failed to update activity"
      render 'show'
    end
  end

  def index
  end

  private

    # Paramenters for an activity
    def activity_params
      params.permit(:name, :day, :time, :length, :location)
    end

    # Authenticate user is signed in
    def authenticate
      unless signed_in?
        flash.now[:danger] = 'Cannot Add Activities, Please Sign In!'
        redirect_to("/signin") if current_user.nil?
      end
    end

    # Check the correct user is accesing information
    def correct_user
      @user = User.find_by_username(params[:username])
      redirect_to(root_path) unless current_user?(@user)
    end
end
