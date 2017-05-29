class EventFile < ActiveRecord::Base

  validates :original_filename, :public_id, :resource_type, :secure_url, :event_id, :user_id, presence: true

  belongs_to :event
  belongs_to :user

  scope :images, -> { where(resource_type: "image") }
  scope :files, -> { where(resource_type: "raw") }

  def original_filename_with_suffix
    "#{original_filename}.#{public_id.split(".").last}"
  end

end