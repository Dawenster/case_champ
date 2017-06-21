class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :force_ssl

  helper_method :landing_page?, :submit_competition_pages?, :add_leading_spaces, :user_logged_in?, :current_user

  def landing_page?
    params[:controller] == "pages" && params[:action] == "landing"
  end

  def submit_competition_pages?
    params[:controller] == "competitions" && (params[:action] == "new" || params[:action] == "create" || params[:action] == "confirmation")
  end

  def add_leading_spaces(string)
    "&nbsp;&nbsp;&nbsp;#{string}".html_safe
  end

  def clean_up_competition_error_messages(errors)
    errors.full_messages.to_sentence.gsub("Event", "Competition").gsub("base ", "").downcase
  end

  def redirect_to_login
    redirect_to root_path, alert: "Please log in" unless user_logged_in?
  end

  def redirect_away_from_login
    redirect_to competitions_path
  end

  def user_logged_in?
    nu_token = cookies[:nu_token]
    # Simply checking if cookie is there instead of making too many hits to Kellogg's servers
    nu_token.present?
  end

  def current_user
    @current_user ||= User.find_by_latest_token(cookies[:nu_token])
  end

  private

  def force_ssl(options = {})
    host = options.delete(:host)
    unless request.ssl? or Rails.env.development?
      redirect_options = {:protocol => 'https://', :status => :moved_permanently}
      redirect_options.merge!(:host => host) if host
      flash.keep
      redirect_to redirect_options and return
    else
      true
    end
  end

end
