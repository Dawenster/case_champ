class Milestone < ActiveRecord::Base

  attr_accessible :deadline_at, :description, :event_id

  validates :deadline_at, :description, presence: true

  belongs_to :event

end