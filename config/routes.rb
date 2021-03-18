# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/whiskeys#index'

  scope module: :web do
    resources :users, only: %i[new create]
    resource :session, only: %i[new create destroy]
  end
end
