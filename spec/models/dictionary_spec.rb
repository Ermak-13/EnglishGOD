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

      Translation.create(text: word, value: translation)
      Translation.count.should eq(1)
    end

    it 'should be invalid' do
      word = 'world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      situations = [
        {text: '', value: translation},
      ]

      situations.each do |attributes|
        Translation.create(attributes)
        Translation.count.should eq(0)
      end
    end
  end

  describe '#translate method' do
    it 'translate one word' do
      word = 'world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      dictionary = test_user.dictionary
      dictionary.stub(:google_translate) {translation}
      dictionary.translate(word).value.should eq(translation)

      Translation.count.should eq(1)
      Knowledge.count.should eq(1)
    end

    it 'translate cached word' do
      word = 'world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      dictionary = test_user.dictionary
      dictionary.stub(:google_translate) {raise 'should not be called'}
      Translation.create(text: word, value: translation)

      dictionary.translate(word).value.should eq(translation)
      Translation.count.should eq(1)
      Knowledge.count.should eq(1)

      Knowledge.last.level.should eq(0)
    end

    it 'translate few words' do
      words = 'hello world'
      translation = JSON.parse(RESPONSE_TEMPLATE % {
        trans: 'привет мир',
        orig: words,
        translit: 'privet mir'
      })
      translation.delete('dict')

      dictionary = test_user.dictionary
      dictionary.stub(:google_translate) {translation}
      dictionary.translate(words).value.should eq(translation)
    end
  end
end
