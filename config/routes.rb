Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]

  namespace :api do
    namespace :v1 do
      resources :people, only: [:index]
      resources :companies, only: [:index, :create]
    end
  end

  root to: 'people#index'
end
