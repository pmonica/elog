class Situation < ActiveRecord::Base
  enum sensitivity: { Public: 0, Private: 1, Secret: 2}
  enum level: { Local: 0, National: 1, International: 2}

  has_many :participations
  has_many :organizations, :through => :participations
  has_many :labels
  has_many :tags, :through => :labels
  has_many :events
  belongs_to :user
  belongs_to :organization, :foreign_key => :owner_organization

  validates_presence_of :name, :sensitivity, :description, :level, :user

  def self.active
    where(active: true)
  end

  def owner_organization
    organization
  end

end
