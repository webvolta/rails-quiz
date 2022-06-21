Rails.application.routes.draw do

  resources :people, only: [:index, :new, :create]
  root to: 'people#index'
  get "people/search/email", to: "people#search_by_email"
  get "people/search/name", to: "people#search_by_name"

  post "companies/create/multiple", to: "company#create_multiple"
end
