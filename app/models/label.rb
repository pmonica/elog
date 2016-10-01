class Label < ActiveRecord::Base
  belongs_to :tag
  belongs_to :situation
end
