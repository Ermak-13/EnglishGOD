require 'spec_helper'

describe Translation do
  describe '.validate method' do
    it 'should be valid' do
      word = 'world'
      translation = GoogleApi::response({
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      transaction = Translation.new(text: word, value: translation)
      transaction.valid?().should be_true
    end

    it 'should be invalid' do
      word = 'world'
      translation = GoogleApi::response({
        trans: 'мир',
        orig: word,
        translit: 'mir'
      })

      situations = [
        {text: '', value: translation},
      ]

      situations.each do |attributes|
        transaction = Translation.new(attributes)
        transaction.valid?().should be_false
      end
    end
  end
end
