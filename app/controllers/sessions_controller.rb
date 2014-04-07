class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully Signed In!"
      redirect_to user_path(session[:user_id])
    else
      flash[:danger] = "Invalid username or password"
      render 'new'
    end
  end

  def destroy
  end
end
