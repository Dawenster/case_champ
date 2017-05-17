class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :landing_page?, :submit_competition_page?, :add_leading_spaces

  def landing_page?
    params[:controller] == "pages" && params[:action] == "landing"
  end

  def submit_competition_page?
    params[:controller] == "competitions" && (params[:action] == "new" || params[:action] == "create")
  end

  def add_leading_spaces(string)
    "&nbsp;&nbsp;&nbsp;#{string}".html_safe
  end

  def clean_up_competition_error_messages(errors)
    errors.full_messages.to_sentence.gsub("Event", "Competition").gsub("base ", "").downcase
  end
end
