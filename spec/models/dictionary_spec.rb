require 'spec_helper'

describe Dictionary do
  describe '#translate method' do
    it 'translate one word' do
      word = 'world'
      translation = GoogleApi::response({
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
      translation = GoogleApi::response({
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
      translation = GoogleApi::response({
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
