# frozen_string_literal: true

Rails.application.routes.draw do
  resources :people, only: %i[index new create]
  root to: 'people#index'
end
