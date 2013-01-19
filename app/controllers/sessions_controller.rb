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
      if user.reading_level.blank? || user.reading_preferences.blank?
        flash[:notice] = "Please take a moment and complete your reading level and preferences."
        redirect_to preferences_path
      else
        redirect_to user_home_path
      end
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
