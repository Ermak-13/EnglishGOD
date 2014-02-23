require 'spec_helper'

describe Dictionary do
  RESPONSE_TEMPLATE = <<-EOF
{
  "sentences":[
    {"trans":"%{trans}","orig":"%{orig}","translit":"%{translit}","src_translit":""}
  ],
  "dict":[
    {
      "pos":"noun","terms":["%{trans}"],
      "entry":[
        {"%{trans}":"%{orig}","reverse_translation":["%{orig}"],"score":0.58786964}
      ],
      "base_form":"%{orig}","pos_enum":1
    }
  ],"src":"en","server_time":65
}
EOF

  describe '.validate method' do
    it 'should be valid' do
      word = 'world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      Dictionary.create(word: word, translation: translation)
      Dictionary.count.should eq(1)
    end

    it 'should be invalid' do
      word = 'world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      situations = [
        {word: '', translation: translation},
      ]

      situations.each do |attributes|
        Dictionary.create(attributes)
        Dictionary.count.should eq(0)
      end
    end
  end

  describe '.translate method' do
    it 'translate one word' do
      word = 'world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      Dictionary.stub(:google_translate) {translation}

      Dictionary.translate(word).should eq(translation)
      Dictionary.count.should eq(1)
    end

    it 'translate cached word' do
      word = 'world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      Dictionary.stub(:google_translate) {raise 'should not be called'}
      Dictionary.create(word: word, translation: translation)

      Dictionary.translate(word).should eq(translation)
      Dictionary.count.should eq(1)
    end

    it 'translate few words' do
      words = 'hello world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'привет мир',
        orig: words,
        translit: 'privet mir'
      })
      translation.delete('dict')

      Dictionary.stub(:google_translate) {translation}
      Dictionary.translate(words).should eq(translation)
    end
  end
end
