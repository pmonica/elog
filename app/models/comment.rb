class Comment < ActiveRecord::Base
  enum sensitivity: { Public: 0, Private: 1, Secret: 2}
  enum level: { Local: 0, National: 1, International: 2}

  belongs_to :event
  belongs_to :user
  belongs_to :organization, :foreign_key => :owner_organization

  validates_presence_of :event, :user, :body


  # Are we not doing this (default setting) in the form?
  # after_create :set_default_levels, :if => :new_record?

  # private

  # def set_default_levels
  #   self.sensitivity ||= self.event.sensitivity
  #   self.level ||= self.event.level
  # end
end
