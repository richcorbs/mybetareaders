class SessionsController < ApplicationController

  def new
    authorize Session
    @user = User.new
  end

  def create
    authorize Session
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
    authorize Session
    session[:user_id] = nil
    redirect_to login_path, :notice => 'Logged out.'
  end
end
