class Situation < ActiveRecord::Base
  has_many :participations
  has_many :organizations, :through => :participations
  has_many :events

  validates :name, presence: true
end
