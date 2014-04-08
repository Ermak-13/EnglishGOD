class KnowledgeDecorator < SimpleDelegator
  def translation
    translation = @delegate_sd_obj.translation
    TranslationDecorator.new(translation)
  end
end
