class EventFile < ActiveRecord::Base

  validates :original_filename, :public_id, :resource_type, :secure_url, :event_id, :user_id, presence: true

  belongs_to :event
  belongs_to :user

end