class Competition < ActiveRecord::Base

  validates :name, :category, presence: true

  has_many :events

end