EnglishGOD::Application.routes.draw do
  devise_for :users
  root 'translations#index'

  resources :translations, only: ['index', 'create']
end
