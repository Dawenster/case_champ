class PagesController < ApplicationController

  before_action :redirect_away_from_login, if: :user_logged_in?

  def landing
    @user = User.new
  end

end
