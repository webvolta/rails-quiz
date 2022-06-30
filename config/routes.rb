Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :company do
        get '/page/:page', action: :index, on: :collection
      end
      resources :people
    end
  end
  resources :people, only: [:index, :new, :create]
  root to: 'people#index'
end
