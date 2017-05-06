class Competition < ActiveRecord::Base

  validates :name, :category, presence: true

end