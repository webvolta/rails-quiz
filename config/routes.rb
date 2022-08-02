Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  root to: 'people#index'
 
end
