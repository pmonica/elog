class Organization < ActiveRecord::Base
  has_many :participations
  has_many :situations, :through => :participations
  has_many :users
  belongs_to :organization, :foreign_key => :creator_organization

  validates_presence_of :name
  validates_presence_of :country
  validates_uniqueness_of :name, :scope => [:country]

  def self.active
    where(active: true)
  end
end
