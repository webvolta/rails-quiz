# frozen_string_literal: true

Rails.application.routes.draw do
  resources :people, only: %i[index new create]
  get 'search_person', to: 'people#search', as: 'search'
  resources :companies, only: %i[index new create]
  get 'serach_company', to: 'companies#search_company', as: 'searchcompany'
  post 'create_multiple_companies', to: 'companies#create_multiple_companies', as: 'createmultiplecompanies'
  root to: 'people#index'
end
