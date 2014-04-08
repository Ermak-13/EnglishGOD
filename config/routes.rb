EnglishGOD::Application.routes.draw do
  devise_for :users
  root 'translations#index'

  resources :translations, only: ['index', 'create']
  resource :dictionary, only: ['show']
end
