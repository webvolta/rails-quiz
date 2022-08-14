Rails.application.routes.draw do
  
  resources :users do
    get 'signup', to: 'users#new', on: :collection
    get 'login', to: 'users#login_form', on: :collection

  #   post 'create', to: 'users#create', on: :member
  #   post 'login', to: 'users#login', on: :member
  end

  resources :users, only: [:new, :create, :signup, :login], path_names: {new: 'sign_up'}



  resources :companies, only: [:index] do
    get 'search/page/:page',  to: 'companies#search', on: :collection
  end

  resources :people, only: [:index, :new, :create] do
    get 'search/page/:page', to: 'people#search', on: :collection

  end

  root to: 'people#index'
end
