class User < ActiveRecord::Base

  has_many :interests
  has_many :events, through: :interests
  has_many :event_files

  scope :admin, -> { where(admin: true) }

  DEFAULT_IMAGE = "user-default_tykgaw"

  def update_details
    user_details = Kellogg::User.fetch_user_details(username)

    self.first_name = user_details["FirstName"]
    self.last_name  = user_details["LastName"]
    self.email      = user_details["EMail"]
    self.program    = user_details["Prog"]
    self.majors     = user_details["Majors"]
    self.image_url  = set_image(user_details["StudentPicURL"])
    self.class_year = user_details["Class"].to_i

    self
  rescue => e
    Rollbar.error(e)
    { message: e.message, error: true }
  end

  def interested_in?(event)
    event.users.include?(self)
  end

  def interest_for(event)
    event.interests.where(user_id: self.id).first
  end

  def name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      username
    end
  end

  def program_and_year
    "#{program}, Class of #{class_year}"
  end

  def is_admin?
    !!admin
  end

  private

  def set_image(url)
    if url.blank?
      DEFAULT_IMAGE
    else
      cloudinary_object = Cloudinary::Uploader.upload(url)
      cloudinary_object['public_id']
    end
  end

end
