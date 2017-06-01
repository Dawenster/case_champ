RailsAdmin.config do |config|
  config.parent_controller = "::ApplicationController"
  config.current_user_method(&:current_user)
  config.authorize_with do |controller|
    unless current_user.try(:is_admin?)
      redirect_to '/', alert: "You are not an admin"
    end
  end
end