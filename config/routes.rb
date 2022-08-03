Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :show, :create]
    end
  end

  resources :people, only: [:index, :new, :create]
  root to: 'people#index'
 
end
