Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'company/index'
      get 'company/show'
      resources :people, only: [:index, :show, :create]
    end
  end

  resources :people, only: [:index, :new, :create]
  root to: 'people#index'
 
end
