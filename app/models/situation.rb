class Situation < ActiveRecord::Base
  enum sensitivity: { publico: 0, privado: 1, secreto: 2}
  enum level: { local: 0, national: 1, international: 2}

  has_many :participations
  has_many :organizations, :through => :participations
  has_many :events
  belongs_to :user
  belongs_to :organization, :foreign_key => :owner_organization

  validates_presence_of :name, :sensitivity, :level, :user

  def self.active
    where(active: true)
  end

  def owner_organization
    organization
  end

end
