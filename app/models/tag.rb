class Tag < ActiveRecord::Base
  has_many :labels
  has_many :situations, :through => :labels
end
