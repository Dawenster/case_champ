class Event < ActiveRecord::Base

  attr_accessible :name, :sponsor, :description, :city, :state_and_country, :min_team_size, :max_team_size, 
                  :num_kellogg_teams_allowed, :logistics, :application, :application_url, :contact_name,
                  :position_and_organization, :contact_email, :contact_phone, :competition_id, :image_url

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

  accepts_nested_attributes_for :prizes, allow_destroy: true, :reject_if => proc { |p| p['description'].blank? }
  accepts_nested_attributes_for :milestones, allow_destroy: true, :reject_if => proc { |p| p['deadline_at'].blank? && p['description'].blank? }

  scope :published, -> { where("published is true") }

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