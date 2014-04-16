class FoodsController < ApplicationController
  layout "layouts/users"

  # Checks correct user and authenticates 
  before_filter :authenticate
  before_filter :correct_user

  # Generates new food form
  def new
    @food = Food.new
  end

  #Creates a new food
  def create
    @user = User.find_by_username(params[:username])
    @food = @user.foods.new(food_params)
    if @food.save
      flash[:success] = "Food Successfully Added!"
      redirect_to exercise_food_path(@user.username)
    else
      render 'new'
    end
  end

  # Supplies information to display foods
  def show
    @user = User.find_by_username(params[:username])
    @food = Food.find params[:id]
    unless @user.foods.include? @food
      flash[:danger] = "Error: Invalid Food Item"
      redirect_to exercise_food_path(params[:username])
    end
  end

  # Removes a food from database
  def destroy
    @user = User.find_by_username(params[:username])
    @food = Food.find params[:id]
    unless @user.foods.include? @food
      flash[:danger] = "Error: Invalid Food Item"
      redirect_to exercise_food_path(params[:username])
    else
      @food.destroy
      flash[:success] = "Food Successfully Deleted!"
      redirect_to exercise_food_path(@user.username)
    end
  end

  #Updates food in database
  def update
    @food = Food.find_by_id(params[:id])
    @food.update_attributes(food_params)
    if @food.save
      flash[:success] = "Food Successfully Saved!"
      redirect_to show_food_path(username: @user.username, id: @food.id)
    else
      flash.now[:danger] = "Error: Failed to update food"
      render 'show'
    end
  end

  def index
  end

  private

  # Paramenters for a food
    def food_params
      params.permit(:name, :day, :time, :calories)
    end

    # Authenticate user is signed in
    def authenticate
      unless signed_in?
        flash.now[:danger] = 'Cannot Add Foods, Please Sign In!'
        redirect_to("/signin") if current_user.nil?
      end
    end

    # Check the correct user is accesing information
    def correct_user
      @user = User.find_by_username(params[:username])
      redirect_to(root_path) unless current_user?(@user)
    end
end
