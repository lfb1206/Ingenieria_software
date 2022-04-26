# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
    },
    path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout', sign_up: 'register'
    }
  devise_for :usuarios
  root 'articles#index'

  get '/articles', to: 'articles#index'
end

