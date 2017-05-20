class UsersController < ApplicationController

  def login
    username = params[:username]
    password = params[:password]
    
    nu_token = Kellogg::User.login(username, password)

    if Kellogg::User.validate_nu_token(nu_token)
      user = User.find_or_initialize_by(username: username)
      if user.nil? || user.requires_update?
        user = user.create_or_update_user
      end

      begin
        user.save!
      rescue => e
        Rollbar.error(e)
      end

      cookies[:nu_token] = nu_token
      redirect_to competitions_path
    else
      redirect_to root_path, alert: "Username or password incorrect"
    end
  end

end
