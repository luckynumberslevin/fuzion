class Competition < ActiveRecord::Base
  
  TYPES = ["Amical", "Coupe", "Championnat"]

  has_many :team_competitions
  has_many :teams, :through => :team_competitions

  has_many :matches

  attr_accessor :in_total

  scope :not_ended, where(ended: false)
end
