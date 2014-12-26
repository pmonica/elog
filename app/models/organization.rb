class Organization < ActiveRecord::Base
  has_many :participations
  has_many :situations, :through => :participations
  has_many :users

  validates_presence_of :name
  validates_presence_of :country
end
