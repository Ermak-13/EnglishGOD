class TranslationDecorator < SimpleDelegator
  def value()
    @delegate_sd_obj['sentences'][0]['trans']
  end

  def probable_values()
    probable_values = {}
    if @delegate_sd_obj['dict']
      @delegate_sd_obj['dict'].each do |i|
        probable_values[i['pos']] = i['terms']
      end
    end

    probable_values
  end
end

class DictionaryDecorator < SimpleDelegator
  def translation
    translation = super()
    TranslationDecorator.new(translation)
  end
end

class TranslationsController < ApplicationController
  def index
    text = params[:text]
    if text
      @form = Dictionary.new(word: text)

      translation = Dictionary.translate(text)
      @translation = TranslationDecorator.new(translation)
    else
      @form = Dictionary.new
    end

    @dictionary = Dictionary.order('created_at DESC').limit(10).map do |dictionary|
      DictionaryDecorator.new(dictionary)
    end
  end

  def create
    dictionary = Dictionary.new(params[:dictionary].permit(:word))
    if dictionary.valid?
      redirect_to root_path(text: dictionary.word)
    else
      redirect_to root_path
    end
  end
end
