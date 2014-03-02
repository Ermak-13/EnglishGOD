class TranslationDecorator < SimpleDelegator
  def value()
    @delegate_sd_obj.value['sentences'][0]['trans']
  end

  def probable_values()
    probable_values = {}
    if @delegate_sd_obj.value['dict']
      @delegate_sd_obj.value['dict'].each do |i|
        probable_values[i['pos']] = i['terms']
      end
    end

    probable_values
  end
end

class TranslationsController < ApplicationController
  def index
    text = params[:text]
    @form = Translation.new(text: text)

    if text
      translation = Dictionary.translate(text)
      @translation = TranslationDecorator.new(translation)
    end

    @translations = Translation.order('created_at DESC').limit(10).map do |translation|
      TranslationDecorator.new(translation)
    end
  end

  def create
    translation = Translation.new(params[:translation].permit(:text))
    if translation.valid?
      redirect_to root_path(text: translation.text)
    else
      redirect_to root_path
    end
  end
end
