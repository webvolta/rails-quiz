Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]

  namespace :api do
    resources :people, only: [:index]
    resources :companies, only: [:index, :create]
  end

  root to: 'people#index'
end
