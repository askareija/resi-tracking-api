# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  post '/tracks', to: 'tracks#index', as: 'tracks'
  get '/tracks/histories', to: 'tracks#histories', as: 'track_user_histories'
  get '/tracks/history/id', to: 'tracks#history_show', as: 'track_user_history'

  resources :users, only: :create do
    collection do
      post 'login'
    end
  end
end
