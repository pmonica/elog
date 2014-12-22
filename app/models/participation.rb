class Participation < ActiveRecord::Base
  belongs_to :organization
  belongs_to :situation
end
