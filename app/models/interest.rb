class Interest < ActiveRecord::Base

  validates :event_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :event_id, message: "already interested in the event" }

  belongs_to :event
  belongs_to :user

  CREATE_BUTTON = "create"
  DESTROY_BUTTON = "destroy"

end