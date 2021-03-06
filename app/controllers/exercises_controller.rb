class ExercisesController < ApplicationController
  layout "layouts/users"

  # Checks correct user and authenticates 
  before_filter :authenticate
  before_filter :correct_user

  # Generates new Exercise form
  def new
    @exercise = Exercise.new
  end

  #Creates a new Exercise
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

  # Removes an ecercise from database
  def destroy
    @user = User.find_by_username(params[:username])
    @exercise = Exercise.find params[:id]
    unless @user.exercises.include? @exercise
      flash[:danger] = "Error: Invalid exercise"
      redirect_to exercise_food_path(params[:username])
    else
      @exercise.destroy
      flash[:success] = "Exercise Successfully Deleted!"
      redirect_to exercise_food_path(@user.username)
    end
  end

  #Updates exercise in database
  def update
    @exercise = Exercise.find_by_id(params[:id])
    @exercise.update_attributes(exercise_params)
    if @exercise.save
      flash[:success] = "Exercise Successfully Saved!"
      redirect_to show_exercise_path(username: @user.username, id: @exercise.id) #Needs to be changed to exercise path
    else
      flash.now[:danger] = "Error: Failed to update exercise"
      render 'show'
    end
  end

   # Supplies information to display Exercises
  def show
    @user = User.find_by_username(params[:username])
    @exercise = Exercise.find params[:id]
    unless @user.exercises.include? @exercise
      flash[:danger] = "Error: Invalid Food Item"
      redirect_to exercise_food_path(params[:username])
    end
  end

  def index
  end

  private

  # Paramenters for an exercise
  def exercise_params
    params.permit(:name, :day, :time, :calories)
  end

 # Authenticate user is signed in
  def authenticate
    unless signed_in?
      flash.now[:danger] = 'Cannot Add Exercise, Please Sign In!'
      redirect_to("/signin") if current_user.nil?
    end
  end

  # Check the correct user is accesing information
  def correct_user
    @user = User.find_by_username(params[:username])
    redirect_to(root_path) unless current_user?(@user)
  end

end
