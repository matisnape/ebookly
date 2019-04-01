class ApplicationController < ActionController::Base
  helper_method :current_user

  protected

  def require_login
    return unless current_user.blank?
    redirect_to login_path, notice: "You need to be logged in to access the site"
  end

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end
end
