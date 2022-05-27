# frozen_string_literal: true

Rails.application.routes.draw do
  
  # INICIO --------------------------------------
  root 'articles#index'
  get '/articles', to: 'articles#index'

  # RESENAS --------------------------------------

  #### CREATE
  get '/resenas/new', to: 'resenas#new', as: 'resenas'
  post '/resenas', to: 'resenas#create', as: 'resenas_create'

  #### READ
  get '/resenas', to: 'resenas#index', as: 'resenas_index'
  get '/resenas/:id', to: 'resenas#show', as: 'resenas_show'

  #### UPDATE
  get '/resenas/:id/edit', to: 'resenas#edit', as: 'resenas_edit'
  patch '/resenas/:id', to: 'resenas#update', as: 'resenas_update'

  #### DELETE
  delete '/resenas/:id', to: 'resenas#delete', as: 'resenas_delete'
  # REQUEST --------------------------------------

  #### CREATE
  get '/requests/new', to: 'requests#new', as: 'requests'
  post '/requests', to: 'requests#create', as: 'requests_create'

  #### READ
  get '/requests', to: 'requests#index', as: 'requests_index'
  get '/requests/:id', to: 'requests#show', as: 'requests_show'

  #### UPDATE
  get '/requests/:id/edit', to: 'requests#edit', as: 'requests_edit'
  patch '/requests/:id', to: 'requests#update', as: 'requests_update'

  #### DELETE
  delete '/requests/:id', to: 'requests#delete', as: 'requests_delete'

  # TURNOS --------------------------------------

  #### CREATE
  get '/turnos/new', to: 'turnos#new', as: 'turnos'
  post '/turnos', to: 'turnos#create', as: 'turnos_create'

  #### READ
  get '/turnos', to: 'turnos#index', as: 'turnos_index'
  get '/turnos/:id', to: 'turnos#show', as: 'turnos_show'

  #### UPDATE
  get '/turnos/:id/edit', to: 'turnos#edit', as: 'turnos_edit'
  patch '/turnos/:id', to: 'turnos#update', as: 'turnos_update'

  #### DELETE
  delete '/turnos/:id', to: 'turnos#delete', as: 'turnos_delete'

  # TURNOS --------------------------------------

  #### CREATE
  get '/mensajes/new', to: 'mensajes#new', as: 'mensajes'
  post '/mensajes', to: 'mensajes#create', as: 'mensajes_create'

  #### READ
  get '/mensajes', to: 'mensajes#index', as: 'mensajes_index'
  get '/mensajes/:id', to: 'mensajes#show', as: 'mensajes_show'

  #### UPDATE
  get '/mensajes/:id/edit', to: 'mensajes#edit', as: 'mensajes_edit'
  patch '/mensajes/:id', to: 'mensajes#update', as: 'mensajes_update'

  #### DELETE
  delete '/mensajes/:id', to: 'mensajes#delete', as: 'mensajes_delete'

  # USERS --------------------------------------

  #### DEVISE
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  #### READ
  devise_scope :user do
    get 'users/show', to: 'users/registrations#show', as: 'users_show'
    post 'users/edit/:id', to: 'users/registrations#edit', as: 'users_edit'
    delete 'users/:id', to: 'users/registrations#destroy', as: 'users_destroy'
  end
end
