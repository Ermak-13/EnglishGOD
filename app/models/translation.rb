class Translation < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :text, presence: true

  def text=(text)
    write_attribute(:text, text.downcase()) if text.present?
  end

  def value()
    JSON.parse(read_attribute(:value) || '{}')
  end

  def value=(translation)
    write_attribute(:value, JSON.dump(translation))
  end
end
