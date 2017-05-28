class Milestone < ActiveRecord::Base

  attr_accessible :deadline_at, :description, :event_id

  validates :deadline_at, :description, presence: true

  belongs_to :event

  scope :ordered, -> { order(:deadline_at) }

end