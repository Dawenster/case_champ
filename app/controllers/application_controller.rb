class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :landing_page?, :submit_competition_page?, :add_leading_spaces

  def landing_page?
    params[:controller] == "pages" && params[:action] == "landing"
  end

  def submit_competition_page?
    params[:controller] == "competitions" && params[:action] == "new"
  end

  def add_leading_spaces(string)
    "&nbsp;&nbsp;#{string}".html_safe
  end
end
