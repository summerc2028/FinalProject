class FoodsController < ApplicationController
  layout "layouts/users"

  before_filter :authenticate
  before_filter :correct_user

  def new
    @food = Food.new
  end

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

  def show
    @user = User.find_by_username(params[:username])
    @food = Food.find params[:id]
    unless @user.foods.include? @food
      flash[:danger] = "Error: Invalid Food Item"
      redirect_to exercise_food_path(params[:username])
    end
  end

  def destroy
    @user = User.find_by_username(params[:username])
    @food = Food.find params[:id]
    unless @user.foods.include? @food
      flash[:danger] = "Error: Invalid Food Item"
      redirect_to exercise_food_path(params[:username])
    else
      @food.destroy
      redirect_to exercise_food_path(@user.username)
    end
  end

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

    def food_params
      params.permit(:name, :day, :time, :calories)
    end

    def authenticate
      unless signed_in?
        flash.now[:danger] = 'Cannot Add Foods, Please Sign In!'
        redirect_to("/signin") if current_user.nil?
      end
    end

    def correct_user
      @user = User.find_by_username(params[:username])
      redirect_to(root_path) unless current_user?(@user)
    end
end
