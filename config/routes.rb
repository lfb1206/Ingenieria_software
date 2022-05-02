# frozen_string_literal: true

Rails.application.routes.draw do

  #### INICIO
  root 'articles#index'
  get '/articles', to: 'articles#index'

  #### CREATE
  get 'turnos/new'
  post 'turnos', to: 'turnos#create'

  #### READ
  get 'turnos/index'
  get 'turnos/show'

  #### UPDATE
  get 'turnos/edit'
  patch 'turnos/update', to: 'turnos#update', as: 'turnos_update'

  #### DELETE
  delete 'turnos/delete', to: 'turnos#delete', as: 'turnos_delete'

end
