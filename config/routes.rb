EnglishGOD::Application.routes.draw do
  root 'translations#index'

  resources :translations, only: ['index', 'create']
end
