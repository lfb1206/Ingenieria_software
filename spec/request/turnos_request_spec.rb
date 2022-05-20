# frozen_string_literal: true

require 'rails_helper'

class TurnosTest < ActiveSupport::TestCase
  # Se agrupan todos los tests relacionados al controlador de Profiles, se le dice a Rails que será testeado
  RSpec.describe 'Turno', type: :request do
    # Aquí se utiliza la factory de Turno para la creación de una publicación
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    let!(:turno) { create(:turno) }
    let!(:invalid_attr_turno) { { cantidad_asientos: 5 } }

    # Se describe lo que se testea
    describe 'get new' do
      # Comportamiento esperado
      it 'should return a successful turno' do
        get '/turnos/new'
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get index' do
      # Comportamiento esperado
      it 'should return a successful turno' do
        # Se le señala a Rails que se haga un GET a la ruta /turno
        get '/turnos/index'
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'create' do
      # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
      it 'should increase count of Turno by 1' do
        # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
        expect do
          post '/turnos', params: { turno: turno.attributes }
        end.to change(Turno, :count).by(1)
      end
      # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
      it 'should not increase count of Turno' do
        expect do
          post '/turnos', params: { turno: invalid_attr_turno}
        end.to change(Turno, :count).by(0)
      end
    end

    describe 'edit' do
      it 'should return a successful turno' do
        get "/turnos/edit?id=#{turno.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get_show' do
      it 'should return a successful turno' do
        get "/turnos/show?id=#{turno.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    # describe 'update' do
    #   it 'should change a Turno' do
    #     expect do
    #       patch "/turno/#{turno.id}", params: { turno: { dia_semana: 'Cambio' } }
    #       # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
    #       # Luego se revisa si cambió alguno de los atributos del usuario
    #       turno.reload
    #     end.to change(turno, :dia_semana)
    #   end
    # end

    # En este caso se trata de haer un update pero con atributos que no son válidos por las validaciones hechas.
  
    # describe 'update' do
    #   it 'should not change a Turno' do
    #     expect do
    #       patch "/turno/#{turno.id}", params: { turno: { dia_semana: 'Cambio' } }
    #       # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
    #       # Luego se revisa si cambió alguno de los atributos de la turno
    #       turno.reload
    #     end.to_not change(turno, :attributes)
    #   end
    # end

    # describe 'delete' do
    #   it 'should decrease count of Turno by 1' do
    #     expect do
    #       delete "/turno/#{turno.id}"
    #     end.to change(Turno, :count).by(-1)
    #   end
    # end
  end
end
