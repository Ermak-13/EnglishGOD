class User < ActiveRecord::Base
  ROLES = {
    regular: 1,
    guest: 2,
    admin: 3,
  }

  before_validation :set_role
  after_create :build_dictionary

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  has_many :knowledges
  has_many :translations, through: :knowledges
  has_one :dictionary

  validates :role, presence: true

  private
    def build_dictionary()
      Dictionary.create(user: self)
    end

    def set_role()
      self.role ||= ROLES.fetch(:regular)
    end
end
