class Event < ActiveRecord::Base
  enum sensitivity: { publico: 0, privado: 1, secreto: 2}
  enum level: { local: 0, national: 1, international: 2}

  belongs_to :user
  belongs_to :situation
  belongs_to :organization, :foreign_key => :owner_organization
  has_many :comments

  validates_presence_of :user, :title, :situation, :sensitivity, :level
end
