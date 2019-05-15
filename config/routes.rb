# frozen_string_literal: true

Rails.application.routes.draw do
  post '/tracks', to: 'tracks#index', as: 'tracks'
end
