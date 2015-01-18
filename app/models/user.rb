class User < ActiveRecord::Base
  enum role: { p0: 0, p1: 1, p2: 2, p3: 3, p4: 4, admin: 5 }
  enum clearance: { Public: 0, Private: 1, Secret: 2}

  after_initialize :set_default_role_and_sensitivity

  def set_default_role_and_sensitivity
    self.role ||= :p0
    self.clearance ||= :Public
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :validatable

  has_many :events
  has_many :situations
  belongs_to :organization
  validates_presence_of :organization, :unless => Proc.new { |u| u.admin? }
end
