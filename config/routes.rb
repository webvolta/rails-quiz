Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  resources :companies, except: [:destroy]

  namespace :api do
    namespace :v1 do
      resources :people, only: [:index]
      resources :companies, only: [:create]
      post 'auth/login', to: 'auth#login'
    end
  end

  root to: 'people#index'
end
