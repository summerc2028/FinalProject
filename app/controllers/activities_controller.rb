class ActivitiesController < ApplicationController
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

  def destroy
  end

  def update
  end

  def index
  end

  private

    def activity_params
      params.permit(:name, :day, :time, :length, :location)
    end

    def authenticate
      flash.now[:danger] = 'Cannot Add Activities, Please Sign In!'
      redirect_to("/signin") if current_user.nil?
    end

    def correct_user
      @user = User.find_by_username(params[:username])
      redirect_to(root_path) unless current_user?(@user)
    end
end
