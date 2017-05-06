class Milestone < ActiveRecord::Base

  validates :deadline_at, :description, :event_id, presence: true

  belongs_to :event

end