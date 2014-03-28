class User < ActiveRecord::Base
  after_create :build_dictionary

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  has_many :knowledges
  has_many :translations, through: :knowledges
  has_one :dictionary

  private
    def build_dictionary()
      Dictionary.create(user: self)
    end
end
