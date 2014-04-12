class ExercisesController < ApplicationController
  before_filter :authenticate

  def new
    @exercise = Exercise.new
  end

  def create
  end

  def destroy
  end

  def update
  end

  def index
  end

  def authenticate
    flash[:danger] = 'Cannot Add Exercise, Please Sign In!'
    redirect_to("/signin") if current_user.nil?
  end
end
