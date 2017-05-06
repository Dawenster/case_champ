class Prize < ActiveRecord::Base

  validates :rank, :description, :event_id, presence: true

  belongs_to :event

end