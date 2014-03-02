class Translation < ActiveRecord::Base
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
