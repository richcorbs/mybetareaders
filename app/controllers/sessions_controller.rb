class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.authenticate( params[:email], params[:password] )
    if user
      session[:user_id] = user.id
      redirect_to user_home_path
    else
      flash.now.alert = "Invalid username or password."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, :notice => 'Logged out.'
  end
end
