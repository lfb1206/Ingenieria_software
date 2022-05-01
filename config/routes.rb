# frozen_string_literal: true

Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
=======
>>>>>>> main
  root 'articles#index'

  get '/articles', to: 'articles#index'
end
