class Event < ActiveRecord::Base

  attr_accessible :name, :sponsor, :description, :city, :state_and_country, :min_team_size, :max_team_size, 
                  :num_kellogg_teams_allowed, :logistics, :application, :application_url, :contact_name,
                  :position_and_organization, :contact_email, :contact_phone, :competition_id

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

  belongs_to :competition
  has_many :prizes
  has_many :milestones

  accepts_nested_attributes_for :prizes, allow_destroy: true
  accepts_nested_attributes_for :milestones, allow_destroy: true

end