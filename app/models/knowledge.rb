class Knowledge < ActiveRecord::Base
  before_validation :default_values

  belongs_to :translation
  belongs_to :dictionary
  belongs_to :user

  default_scope { includes(:translation) }

  validates :translation_id, presence: true
  validates :user_id, presence: true
  validates :dictionary_id, presence: true

  validates :level, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100,
  }

  private
    def default_values()
      self.level ||= 0

      tmp = 1
      self.rating = tmp * self.level
    end
end
