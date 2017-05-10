class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :landing_page?, :submit_competition_page?

  def landing_page?
    params[:controller] == "pages" && params[:action] == "landing"
  end

  def submit_competition_page?
    params[:controller] == "competitions" && params[:action] == "new"
  end
end
