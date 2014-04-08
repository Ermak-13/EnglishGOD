class DictionariesController < ApplicationController
  before_action :authenticate_user!

  def show
    knowledges = current_dictionary.knowledges.order('rating DESC')
    @knowledges = knowledges.map do |knowledge|
      KnowledgeDecorator.new(knowledge)
    end
  end
end
