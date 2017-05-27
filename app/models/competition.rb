class Competition < ActiveRecord::Base

  attr_accessible :name, :category
  attr_accessible :events_attributes

  validates :name, :category, presence: true

  has_many :events

  accepts_nested_attributes_for :events, allow_destroy: true

  TIMES = [
    "Upcoming",
    "Past"
  ]
  DEFAULT_TIME = TIMES.first

  ALL_CATEGORIES = "All Categories"

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
  CATEGORIES_WITH_ALL = CATEGORIES.unshift(ALL_CATEGORIES)
  DEFAULT_CATEGORY = ALL_CATEGORIES


  SORT_VALUES = [
    "Date",
    "Prize",
    "Interest"
  ]
  DEFAULT_SORT_VALUE = SORT_VALUES.first

end