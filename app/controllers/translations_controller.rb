class TranslationsController < ApplicationController
  def index
    text = params[:text]
    @form = Translation.new(text: text)

    if text
      translation = current_or_guest_user.dictionary.translate(text)
      @translation = TranslationDecorator.new(translation)
    end

    if user_signed_in?
      knowledges = current_user.knowledges.order('created_at DESC').limit(10)
      @knowledges = knowledges.map do |knowledge|
        KnowledgeDecorator.new(knowledge)
      end
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
