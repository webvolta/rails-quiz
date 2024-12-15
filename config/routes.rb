Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  resources :companies
  root to: 'people#index'
end
