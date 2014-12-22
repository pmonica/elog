class Organization < ActiveRecord::Base
  has_many :participations
  has_many :situations, :through => :participations

  validates :name, presence: true
  validates :country, presence: true
  validates_uniqueness_of :name
end
