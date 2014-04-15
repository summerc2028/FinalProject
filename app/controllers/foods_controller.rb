class FoodsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  layout "layouts/users", except: [:new, :index]


  def new
    @food = Food.new
  end

  def create
    @user = User.find_by_username(params[:username])
    @food = Food.new(food_params)
    @food.update_attribute :user_id, @user.id
    if @food.save
      flash[:success] = "Food Item Successfully Added!"
      redirect_to exercise_food_path(@user.username)
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

  def authenticate
    flash.now[:danger] = 'Cannot Add Food, Please Sign In!'
    redirect_to("/signin") if current_user.nil?
  end

  def correct_user
    @user = User.find_by_username(params[:username])
    redirect_to(root_path) unless current_user?(@user)
  end

end