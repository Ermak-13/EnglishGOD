class Dictionary
  def self.translate(text)
    translation = Translation.find_by_text(text.downcase())

    if not translation
      value = self.google_translate(text)

      if value['dict']
        translation = Translation.create(text: text, value: value)
      else
        # not saving when translated few words
        translation = Translation.new(text: text, value: value)
      end
    end

    translation
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
