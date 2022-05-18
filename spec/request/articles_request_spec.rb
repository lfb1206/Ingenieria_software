# frozen_string_literal: true

require 'rails_helper'

class ArticlesTest < ActiveSupport::TestCase
  # Se agrupan todos los tests relacionados al controlador de Articles, con esta línea se le dice a Rails que será testeado
  RSpec.describe 'Article', type: :request do
    describe 'get index' do
      # Comportamiento esperado
      it 'should return a successful request' do
        # Se le señala a Rails que se haga un GET a la ruta /request
        get '/articles'
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
