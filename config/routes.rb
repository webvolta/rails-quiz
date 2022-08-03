Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :companies, only: [:index, :show, :create]
      resources :people, only: [:index, :show, :create]
    end
  end

  resources :people, only: [:index, :new, :create]
  resources :companies, only: [:index, :new, :edit, :create, :update]
  root to: 'people#index'
 
end
