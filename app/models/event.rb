class Event < ActiveRecord::Base

  validates :name,                      presence: true
  validates :sponsor,                   presence: true
  validates :description,               presence: true
  validates :city,                      presence: true
  validates :state_and_country,         presence: true
  validates :application_url,           presence: true
  validates :contact_name,              presence: true
  validates :position_and_organization, presence: true
  validates :contact_email,             presence: true
  validates :competition_id,            presence: true

  belongs_to :competition
  has_many :prizes
  has_many :milestones

  accepts_nested_attributes_for :prizes, allow_destroy: true
  accepts_nested_attributes_for :milestones, allow_destroy: true

  attr_accessible :prizes, :milestones

end