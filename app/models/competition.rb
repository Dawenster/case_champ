class Competition < ActiveRecord::Base

  attr_accessible :name, :category
  attr_accessible :events_attributes

  validates :name, :category, presence: true

  has_many :events

  accepts_nested_attributes_for :events, allow_destroy: true

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