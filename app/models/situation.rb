class Situation < ActiveRecord::Base
  has_many :participations
  has_many :organizations, :through => :participations

  validates :name, presence: true
end
