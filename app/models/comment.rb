class Comment < ActiveRecord::Base
  enum sensitivity: { publico: 0, privado: 1, secreto: 2}
  enum level: { local: 0, national: 1, internacional: 2}

  belongs_to :event
  belongs_to :user

  validates_presence_of :event, :user, :body
  after_initialize :set_default_levels, :if => :new_record?

  private

  def set_default_levels
    self.sensitivity ||= self.event.sensitivity
    self.level ||= self.event.level
  end
end
