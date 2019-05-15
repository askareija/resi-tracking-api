# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  
  post '/tracks', to: 'tracks#index', as: 'tracks'
  get '/tracks/history', to: 'tracks#history', as: 'track_user_history'
  
  resources :users, only: :create do
    collection do
      post 'login'
    end
  end
end
