class ExercisesController < ApplicationController
  layout "layouts/users"

  before_filter :authenticate
  before_filter :correct_user

  def new
    @exercise = Exercise.new
  end

  def create
    @user = User.find_by_username(params[:username])
    @exercise = @user.exercises.new(exercise_params)
    if @exercise.save
      flash[:success] = "Exercise Successfully Added!"
      redirect_to exercise_food_path(@user.username)
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find_by_username(params[:username])
    @exercise = Exercise.find params[:id]
    unless @user.exercises.include? @exercise
      flash[:danger] = "Error: Invalid exercise"
      redirect_to usernames_path(params[:username])
    else
      @exercise.destroy
      redirect_to usernames_path(@user.username)
    end
  end

  def update
    @exercise = Exercise.find_by_id(params[:id])
    @exercise.update_attributes(activity_params)
    if @exercise.save
      redirect_to show_exercise_path(username: @user.username, id: @exercise.id) #Needs to be changed to exercise path
    else
      flash.now[:danger] = "Error: Failed to update exercise"
      render 'show'
    end
  end

  def index
  end

  private

  def exercise_params
    params.permit(:name, :day, :time, :calories)
  end

  def authenticate
    unless signed_in?
      flash.now[:danger] = 'Cannot Add Exercise, Please Sign In!'
      redirect_to("/signin") if current_user.nil?
    end
  end

  def correct_user
    @user = User.find_by_username(params[:username])
    redirect_to(root_path) unless current_user?(@user)
  end

end
