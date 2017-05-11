class Competition < ActiveRecord::Base

  validates :name, :category, presence: true

  has_many :events

  accepts_nested_attributes_for :events, allow_destroy: true

  attr_accessible :events_attributes

  CATEGORIES = [
    "Analytics", 
    "Business", 
    "Consulting", 
    "Design", 
    "Entrepreneurship", 
    "Finance", 
    "Health Care", 
    "Marketing", 
    "Operations", 
    "Social Impact", 
    "Technology"
  ]

end