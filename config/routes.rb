Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  root to: 'people#index'

  #API
  get 'people_list' => 'people#people_list'
end
