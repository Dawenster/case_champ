class Competition < ActiveRecord::Base

  attr_accessible :name, :category
  attr_accessible :events_attributes

  validates :name, :category, presence: true

  has_many :events

  accepts_nested_attributes_for :events, allow_destroy: true

  TIMES = [
    UPCOMING = "Upcoming",
    PAST     = "Past"
  ]
  DEFAULT_TIME = UPCOMING

  ALL_CATEGORIES = "All Categories"
  CATEGORIES = [
    ANALYTICS        = "Analytics", 
    BUSINESS         = "Business", 
    CASE             = "Case", 
    CONSULTING       = "Consulting", 
    DESIGN           = "Design", 
    ENTREPRENEURSHIP = "Entrepreneurship", 
    FINANCE          = "Finance", 
    HEALTH_CARE      = "Health Care", 
    MARKETING        = "Marketing", 
    OPERATIONS       = "Operations", 
    SOCIAL_IMPACT    = "Social Impact", 
    TECHNOLOGY       = "Technology"
  ]
  CATEGORIES_WITH_ALL = CATEGORIES.unshift(ALL_CATEGORIES)
  DEFAULT_CATEGORY = ALL_CATEGORIES


  SORT_VALUES = [
    DATE     = "Date",
    PRIZE    = "Prize",
    INTEREST = "Interest"
  ]
  DEFAULT_SORT_VALUE = SORT_VALUES.first

end