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
  CATEGORIES_WITH_ALL = [ALL_CATEGORIES] + CATEGORIES
  DEFAULT_CATEGORY = ALL_CATEGORIES

  SORT_VALUES = [
    DATE     = "Date",
    PRIZE    = "Prize",
    INTEREST = "Interest"
  ]
  DEFAULT_SORT_VALUE = SORT_VALUES.first

  TAB_DETAILS           = "details"
  TAB_PARTICIPANTS      = "participants"
  TAB_PAST_COMPETITIONS = "past-competitions"
  TAB_FILES_AND_IMAGES  = "files-and-images"
  TAB_ITEMS = {
    details:           TAB_DETAILS,
    participants:      TAB_PARTICIPANTS,
    past_competitions: TAB_PAST_COMPETITIONS,
    files_and_images:  TAB_FILES_AND_IMAGES
  }
  DEFAULT_TAB_VALUE = TAB_ITEMS[:details]

  DEFAULT_IMAGE = "competition-default_mgxfrl"

  def self.name_dropdowns
    Competition.order(:name).map do |competition|
      [competition.name, competition.id]
    end
  end

  def category_enum
    CATEGORIES
  end

end
