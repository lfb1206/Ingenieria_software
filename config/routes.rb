# frozen_string_literal: true

Rails.application.routes.draw do
  # INICIO --------------------------------------
  get '/articles', to: 'articles#index'

  # RESENAS --------------------------------------

  #### CREATE
  get 'resenas', to: 'resenas#new', as: 'resenas'
  post 'resenas/:id', to: 'resenas#create', as: 'resenas_create'

  #### READ
  get 'resenas/index', to: 'resenas#index', as: 'resenas_index'
  get 'resenas/:id', to: 'resenas#show', as: 'resenas_show'

  #### UPDATE
  get 'resenas/edit/:id', to: 'resenas#edit', as: 'resenas_edit'
  patch 'resenas/:id', to: 'resenas#update', as: 'resenas_update'

  #### DELETE
  delete 'resenas/:id', to: 'resenas#delete', as: 'resenas_delete'
  # REQUEST --------------------------------------

  #### CREATE
  get 'requests', to: 'requests#new', as: 'requests'
  post 'requests/:id', to: 'requests#create', as: 'requests_create'

  #### READ
  get 'requests/index', to: 'requests#index', as: 'requests_index'
  get 'requests/:id', to: 'requests#show', as: 'requests_show'

  #### UPDATE
  get 'requests/edit/:id', to: 'requests#edit', as: 'requests_edit'
  patch 'requests/:id', to: 'requests#update', as: 'requests_update'

  #### DELETE
  delete 'requests/:id', to: 'requests#delete', as: 'requests_delete'

  # TURNOS --------------------------------------

  #### CREATE
  get 'turnos', to: 'turnos#new', as: 'turnos'
  post 'turnos/:id', to: 'turnos#create', as: 'turnos_create'

  #### READ
  root 'turnos#index'
  get 'turnos/index', to: 'turnos#index', as: 'turnos_index'
  get 'turnos/:id', to: 'turnos#show', as: 'turnos_show'

  #### UPDATE
  get 'turnos/edit/:id', to: 'turnos#edit', as: 'turnos_edit'
  patch 'turnos/:id', to: 'turnos#update', as: 'turnos_update'

  #### DELETE
  delete 'turnos/:id', to: 'turnos#delete', as: 'turnos_delete'

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
