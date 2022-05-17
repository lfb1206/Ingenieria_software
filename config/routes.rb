# frozen_string_literal: true

Rails.application.routes.draw do

  # INICIO --------------------------------------
  get '/articles', to: 'articles#index'

  # RESENAS --------------------------------------

  #### CREATE
  get 'resenas/new'
  post 'resenas', to: 'resenas#create'

  #### READ
  get 'resenas/index'
  get 'resenas/show'

  #### UPDATE
  get 'resenas/edit'
  patch 'resenas/update', to: 'resenas#update'

  #### DELETE
  delete 'resenas/delete', to: 'resenas#delete'
  # REQUEST --------------------------------------

  #### CREATE
  get 'requests/new'
  post 'requests', to: 'requests#create'

  #### READ
  get 'requests/index', to: 'requests#index'
  get 'requests/show'

  #### UPDATE
  get 'requests/edit'
  patch 'requests/update', to: 'requests#update', as: 'requests_update'

  #### DELETE
  delete 'requests/delete', to: 'requests#delete', as: 'requests_delete'

  # TURNOS --------------------------------------

  #### CREATE
  get 'turnos/new'
  post 'turnos', to: 'turnos#create'

  #### READ
  root 'turnos#index'
  get 'turnos/index', to: 'turnos#index'
  get 'turnos/show'

  #### UPDATE
  get 'turnos/edit'
  patch 'turnos/update', to: 'turnos#update', as: 'turnos_update'

  #### DELETE
  delete 'turnos/delete', to: 'turnos#delete', as: 'turnos_delete'

  # USERS --------------------------------------

  #### DEVISE
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  #### READ
  devise_scope :user do
    get 'users/show', to: 'users/registrations#show', as: 'users_show'
  end

end
