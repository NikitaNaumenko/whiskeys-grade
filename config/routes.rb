# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/whiskies#index'

  scope module: :web do
    resources :users, only: %i[new create]
    resource :session, only: %i[new create destroy]
    resources :whiskies
  end
end
