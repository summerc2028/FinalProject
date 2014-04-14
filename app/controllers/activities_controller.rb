class ActivitiesController < ApplicationController
  layout "layouts/users", except: [:new, :index]

  before_filter :authenticate
  before_filter :correct_user
  def new
    @activity = Activity.new
  end

  def create
    @user = User.find_by_username(params[:username])
    @activity = Activity.new(activity_params)
    @activity.update_attribute :user_id, @user.id
    if @activity.save!
      flash[:success] = "Activity Successfully Added!"
      redirect_to calendar_path(@user.username)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by_username(params[:username])
    @activity = Activity.find params[:id]
  end

  def destroy
  end

  def update
    @activity = Activity.find_by_id(params[:id])
    @activity.update_attributes(activity_params)
    if @activity.save
      redirect_to show_activity_path(username: @user.username, id: @activity.id)
    else
      flash.now[:danger] = "Error: Failed to update status"
      render 'show'
    end
  end

  def index
  end

  private

    def activity_params
      params.permit(:name, :day, :time, :length, :location)
    end

    def authenticate
      unless signed_in?
        flash.now[:danger] = 'Cannot Add Activities, Please Sign In!'
        redirect_to("/signin") if current_user.nil?
      end
    end

    def correct_user
      @user = User.find_by_username(params[:username])
      redirect_to(root_path) unless current_user?(@user)
    end
end
