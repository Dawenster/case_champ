class User < ActiveRecord::Base

  scope :admin, -> { where(admin: true) }

  def create_or_update_user
    user_details = Kellogg::User.fetch_user_details(username)
    
    self.first_name = user_details["FirstName"]
    self.last_name  = user_details["LastName"]
    self.email      = user_details["EMail"]
    self.program    = user_details["Prog"]
    self.majors     = user_details["Majors"]
    self.image_url  = user_details["StudentPicURL"]
    self.class_year = user_details["Class"].to_i

    self
  end

  def requires_update?
    email.blank?
  end

end