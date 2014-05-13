class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= TeamMember.find session[:team_member_id]
  end
  
  def logged_in?
    session[:team_member_id] != nil
  end
end
