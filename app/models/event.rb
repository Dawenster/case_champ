class Event < ActiveRecord::Base
  include EventAdmin

  DEFAULT_IMAGE_ASPECT_RATIO = "8:5"

  attr_accessible :name, :sponsor, :description, :city, :state_and_country, :min_team_size, :max_team_size,
                  :num_kellogg_teams_allowed, :logistics, :application, :application_url, :contact_name,
                  :position_and_organization, :contact_email, :contact_phone, :competition_id, :image_url,
                  :published

  attr_accessible :prizes_attributes, :milestones_attributes

  validates :name,                      presence: true
  validates :sponsor,                   presence: true
  validates :description,               presence: true
  validates :city,                      presence: true
  validates :state_and_country,         presence: true
  validates :application_url,           presence: true
  validates :contact_name,              presence: true
  validates :position_and_organization, presence: true
  validates :contact_email,             presence: true
  validates :image_url,                 presence: true

  validate :team_size_range
  validate :has_at_least_one_prize
  validate :has_at_least_one_milestone

  belongs_to :competition
  has_many :prizes
  has_many :milestones
  has_many :interests
  has_many :users, through: :interests
  has_many :event_files

  accepts_nested_attributes_for :prizes, allow_destroy: true, :reject_if => proc { |p| p['description'].blank? }
  accepts_nested_attributes_for :milestones, allow_destroy: true, :reject_if => proc { |p| p['deadline_at'].blank? && p['description'].blank? }

  scope :first_prize, -> {
    joins(:prizes)
    .where("prizes.rank = (SELECT MAX(prizes.rank) FROM prizes WHERE prizes.event_id = events.id)")
  }
  scope :first_milestone, -> {
    joins(:milestones)
    .where("milestones.deadline_at = (SELECT MIN(milestones.deadline_at) FROM milestones WHERE milestones.event_id = events.id)")
  }

  scope :published, -> { where("published is true") }
  scope :upcoming, -> { first_milestone.where("milestones.deadline_at >= ?", Time.current) }
  scope :past, -> { first_milestone.where("milestones.deadline_at < ?", Time.current) }
  scope :sort_by_date, -> { first_milestone.order("milestones.deadline_at") }
  scope :sort_by_prize, -> { first_prize.order("prizes.description") }

  def first_milestone
    milestones.order(:deadline_at).first
  end

  def city_and_state_and_country
    "#{city}, #{state_and_country}"
  end

  def self.sort_by_interest
    Event.all.sort_by do |event|
      event.users.count
    end.reverse
  end

  def unpublished?
    !published
  end

  private

  def team_size_range
    if min_team_size.present? && max_team_size.present? && min_team_size > max_team_size
      errors.add(:min_team_size, "should be less than max team size")
    end
  end

  def has_at_least_one_prize
    if prizes.length == 0
      errors.add(:base, "must have at least one prize")
    end
  end

  def has_at_least_one_milestone
    if milestones.length == 0
      errors.add(:base, "must have at least one milestone")
    end
  end

end
