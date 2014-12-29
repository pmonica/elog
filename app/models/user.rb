class User < ActiveRecord::Base
  enum role: { p1: 0, p2: 1, p3: 2, admin: 4 }
  enum clearance: { publico: 0, privado: 1, secreto: 2}

  after_initialize :set_default_role_and_sensitivity

  def set_default_role_and_sensitivity
    self.role ||= :p1
    self.clearance ||= :publico
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :situations
  belongs_to :organization
  validates_presence_of :organization, :unless => Proc.new { |u| u.admin? }
end
