Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  resources :companies
  root to: 'people#index'

  namespace :api do
    resources :people, only: :index
    resources :companies, only: :index
  end
end
