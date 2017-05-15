class Prize < ActiveRecord::Base

  attr_accessible :rank, :amount_in_dollars, :description, :event_id

  validates :rank, :description, presence: true

  belongs_to :event

end