class Dictionary < ActiveRecord::Base
  validates :word, presence: true

  def word=(word)
    write_attribute(:word, word.downcase())
  end

  def translation()
    JSON.parse(read_attribute(:translation) || '{}')
  end

  def translation=(translation)
    write_attribute(:translation, JSON.dump(translation))
  end

  def self.translate(text)
    word = Dictionary.find_by_word(text.downcase())
    if word
      return word.translation
    else
      translation = self.google_translate(text)

      if translation['dict']
        Dictionary.create(word: text, translation: translation)
      end
      return translation
    end
  end

  def self.google_translate(text)
      googleapi_url = 'http://translate.google.ru/translate_a/t?client=x&text=%{text}&sl=en&tl=ru'

      uri = URI(googleapi_url % {
        text: text.sub(' ', '%20')
      })
      response = Net::HTTP.get_response(uri)

      response_body = Iconv.iconv('UTF-8', 'KOI8-R', response.body)
      if response_body.present?
        translation = JSON.parse(response_body[0])
      else
        translation = ''
      end

      translation
  end
end
