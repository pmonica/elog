class Event < ActiveRecord::Base
  enum sensitivity: { Public: 0, Private: 1, Secret: 2}
  enum level: { Local: 0, National: 1, International: 2}

  belongs_to :user
  belongs_to :situation
  belongs_to :organization, :foreign_key => :owner_organization
  has_many :comments

  validates_presence_of :user, :title, :situation, :sensitivity, :level

end
