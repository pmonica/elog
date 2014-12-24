class Situation < ActiveRecord::Base
  enum sensitivity: { publico: 0, privado: 1, secreto: 2}
  enum level: { local: 0, national: 1, internacional: 2}

  has_many :participations
  has_many :organizations, :through => :participations
  has_many :events

  validates :name, presence: true
  validates :sensitivity, presence: true
  validates :level, presence: true
end
