class ApplicationController < ActionController::Base

  after_filter :verify_authorized

  protect_from_forgery

  include Pundit

  helper_method :current_user

  def require_login
    redirect_to login_path if (current_user.nil? && params[:t])
  end

  def require_admin
    if current_user && !current_user.admin?
      redirect_to "/whats_hot" if not (current_user && current_user.admin?)
    elsif current_user.nil?
      redirect_to "/"
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def unauthorized
    redirect_to "/", :alert => "Unauthorized."
  end
end
