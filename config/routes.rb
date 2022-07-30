Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  resources :company, only: [:index, :new, :create]
  root to: 'people#index'

  #API
  get 'people_list' => 'people#people_list'
  get 'company_list' => 'company#company_list'
  get 'company_add' => 'company#company_add'
end
