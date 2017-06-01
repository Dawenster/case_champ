class UsersController < ApplicationController

  def login
    username = params[:username]
    password = params[:password]
    
    redirect_to root_path, alert: "Please use your NetID to sign in" and return if username.include? "@"

    nu_token = Kellogg::User.login(username, password)

    if Kellogg::User.validate_nu_token(nu_token)
      user = User.find_or_initialize_by(username: username)
      user = user.update_details

      redirect_to root_path, alert: user[:message] and return if user[:error]

      user.latest_token = nu_token

      begin
        user.save!
      rescue => e
        Rollbar.error(e)
      end

      # Kellogg tokens expire after 4 hours of inactivity, 12 hours if active
      # Just going to set to 4 hours
      cookies[:nu_token] = { value: nu_token, expires: 4.hours.from_now }
      redirect_to competitions_path
    else
      redirect_to root_path, alert: "Username or password incorrect"
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
