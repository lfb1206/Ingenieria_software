# frozen_string_literal: true

require 'rails_helper'

class ResenasTest < ActiveSupport::TestCase
  # Se agrupan todos los tests relacionados al controlador de Profiles, se le dice a Rails que será testeado
  RSpec.describe 'Resena', type: :request do
    # Aquí se utiliza la factory de Resena para la creación de una publicación
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    let!(:turno) { create(:turno) }
    let!(:resena) { create(:resena) }

    # Se describe lo que se testea
    describe 'get new' do
      # Comportamiento esperado
      it 'should return a successful resena' do
        get '/resenas/new'
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get index' do
      # Comportamiento esperado
      it 'should return a successful resena' do
        # Se le señala a Rails que se haga un GET a la ruta /resena
        get '/resenas/index'
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'create' do
      # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
      it 'should increase count of Resena by 1' do
        # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
        expect do
          post '/resenas', params: { resena: resena.attributes }
        end.to change(Resena, :count).by(1)
      end
      # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
      # it 'should not increase count of Resena' do
      #   expect do
      #     post '/resenas', params: { resena: invalid_attr_resena}
      #   end.to change(Resena, :count).by(0)
      # end
    end

    describe 'edit' do
      it 'should return a successful resena' do
        get "/resenas/edit?id=#{resena.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get_show' do
      it 'should return a successful resena' do
        get "/resenas/show?id=#{resena.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    # describe 'update' do
    #   it 'should change a Resena' do
    #     expect do
    #       patch "/resena/#{resena.id}", params: { resena: { calificacion: 2 } }
    #       # Se recarga la instancia de resena nuevamente con los posibles nuevos atributos
    #       # Luego se revisa si cambió alguno de los atributos del usuario
    #       resena.reload
    #     end.to change(resena, :calificacion)
    #   end
    # end

    # En este caso se trata de haer un update pero con atributos que no son válidos por las validaciones hechas.

    # describe 'update' do
    #   it 'should not change a Resena' do
    #     expect do
    #       patch "/resena/#{resena.id}", params: { resena: { calificacion: 3 } }
    #       # Se recarga la instancia de resena nuevamente con los posibles nuevos atributos
    #       # Luego se revisa si cambió alguno de los atributos de la resena
    #       resena.reload
    #     end.to_not change(resena, :attributes)
    #   end
    # end

    # describe 'delete' do
    #   it 'should decrease count of Resena by 1' do
    #     expect do
    #       DELETE "/resena/#{resena.id}"
    #     end.to change(Resena, :count).by(-1)
    #   end
    # end
  end
end
