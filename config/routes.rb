# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/whiskeys#index'

  scope module: :web do
    resources :users, only: %i[new create]
    resources :sessions, only: %i[new create]
  end
end
