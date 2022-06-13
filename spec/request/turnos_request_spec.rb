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
    let!(:turno) { create(:turno, hora_salida: '12:10') }
    let!(:turno1) { create(:turno, hora_salida: '15:00') }
    let!(:turno2) { create(:turno, hora_salida: '06:10') }
    let!(:request) { create(:request, estado: 'Pendiente', user: @user, turno: turno) }
    let!(:invalid_attr_turno) { { cantidad_asientos: 5 } }

    # Se describe lo que se testea
    describe 'get new' do
      # Comportamiento esperado
      it 'should return a successful turno' do
        get turnos_path(id: turno.id)
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get index' do
      # Comportamiento esperado
      it 'should return a successful turno' do
        # Se le señala a Rails que se haga un GET a la ruta /turno
        get turnos_index_path(id: turno.id)
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
      it 'filtro direccion llegada' do
        # Se le señala a Rails que se haga un GET a la ruta /turno
        ruta = '/turnos?form%5Btipo%5D=1&form%5Btipo_lista%5D=1&form%5Bdireccion_salida%5D=Casa_Central&form%' \
               '5Bdireccion_llegada%5D=&form%5Bdia_semana%5D=Martes&form%5Bhora_salida_min%281i%29%5D=2022&fo' \
               'rm%5Bhora_salida_min%282i%29%5D=6&form%5Bhora_salida_min%283i%29%5D=13&form%5Bhora_salida_min%' \
               '284i%29%5D=00&form%5Bhora_salida_min%285i%29%5D=01&form%5Bhora_salida_max%281i%29%5D=2022&form' \
               '%5Bhora_salida_max%282i%29%5D=6&form%5Bhora_salida_max%283i%29%5D=13&form%5Bhora_salida_max%284' \
               'i%29%5D=23&form%5Bhora_salida_max%285i%29%5D=59&commit=Filtrar'
        get ruta
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
      it 'filtro direccion salida' do
        # Se le señala a Rails que se haga un GET a la ruta /turno
        ruta = '/turnos?form%5Btipo%5D=1&form%5Btipo_lista%5D=1&form%5Bdireccion_salida%5D=&form%5Bdireccion_llegad' \
               'a%5D=Campus_Lo_contador&form%5Bdia_semana%5D=&form%5Bhora_salida_min%281i%29%5D=2022&form%5Bhora_sal' \
               'ida_min%282i%29%5D=6&form%5Bhora_salida_min%283i%29%5D=13&form%5Bhora_salida_min%284i%29%5D=06&form%' \
               '5Bhora_salida_min%285i%29%5D=04&form%5Bhora_salida_max%281i%29%5D=2022&form%5Bhora_salida_max%282i%2' \
               '9%5D=6&form%5Bhora_salida_max%283i%29%5D=13&form%5Bhora_salida_max%284i%29%5D=10&form%5Bhora_salida_' \
               'max%285i%29%5D=52&commit=Filtrar'
        get ruta
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
      it 'filtro hora' do
        # Se le señala a Rails que se haga un GET a la ruta /turno
        ruta = '/turnos?form%5Btipo%5D=1&form%5Btipo_lista%5D=1&form%5Bdireccion_salida%5D=&form%5Bdireccion_llegad' \
               'a%5D=&form%5Bdia_semana%5D=&form%5Bhora_salida_min%281i%29%5D=2022&form%5Bhora_salida_min%282i%29%5' \
               'D=6&form%5Bhora_salida_min%283i%29%5D=13&form%5Bhora_salida_min%284i%29%5D=06&form%5Bhora_salida_mi' \
               'n%285i%29%5D=01&form%5Bhora_salida_max%281i%29%5D=2022&form%5Bhora_salida_max%282i%29%5D=6&form%5Bh' \
               'ora_salida_max%283i%29%5D=13&form%5Bhora_salida_max%284i%29%5D=15&form%5Bhora_salida_max%285i%29%5D' \
               '=59&commit=Filtrar'
        get ruta
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
      it 'filtro hora exacta' do
        # Se le señala a Rails que se haga un GET a la ruta /turno
        ruta = '/turnos?form%5Btipo%5D=1&form%5Btipo_lista%5D=1&form%5Bdireccion_salida%5D=&form%5Bdireccion_llegad' \
               'a%5D=&form%5Bdia_semana%5D=&form%5Bhora_salida_min%281i%29%5D=2022&form%5Bhora_salida_min%282i%29%5' \
               'D=6&form%5Bhora_salida_min%283i%29%5D=13&form%5Bhora_salida_min%284i%29%5D=12&form%5Bhora_salida_mi' \
               'n%285i%29%5D=02&form%5Bhora_salida_max%281i%29%5D=2022&form%5Bhora_salida_max%282i%29%5D=6&form%5Bh' \
               'ora_salida_max%283i%29%5D=13&form%5Bhora_salida_max%284i%29%5D=12&form%5Bhora_salida_max%285i%29%5D' \
               '=50&commit=Filtrar'
        get ruta
        # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'create' do
      # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
      it 'should increase count of Turno by 1' do
        # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
        expect do
          post turnos_create_path(id: turno.id), params: { turno: turno.attributes }
        end.to change(Turno, :count).by(1)
      end
      # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
      it 'should not increase count of Turno' do
        expect do
          post turnos_create_path(id: turno.id), params: { turno: invalid_attr_turno }
        end.to change(Turno, :count).by(0)
      end
    end

    describe 'edit' do
      it 'should return a successful turno' do
        get turnos_edit_path(id: turno.id)
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'get_show' do
      it 'should return a successful turno' do
        get turnos_show_path(id: turno.id)
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'update' do
      it 'should change a Turno' do
        expect do
          patch turnos_update_path(id: turno.id), params: { turno: { dia_semana: 'Cambio' } }
          # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
          # Luego se revisa si cambió alguno de los atributos del usuario
          turno.reload
        end.to change(turno, :dia_semana)
      end
      it 'should change a Turno' do
        expect do
          patch turnos_update_path(id: turno.id), params: { turno: { cantidad_asientos: 0 } }
          # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
          # Luego se revisa si cambió alguno de los atributos del usuario
          turno.reload
        end.to change(turno, :cantidad_asientos)
      end
      it 'should not change a Turno' do
        expect do
          patch turnos_update_path(id: turno.id), params: { turno: { dia_semana: nil } }
          # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
          # Luego se revisa si cambió alguno de los atributos de la turno
          turno.reload
        end.to_not change(turno, :attributes)
      end
    end

    describe 'delete' do
      it 'should decrease count of Turno by 1' do
        expect do
          delete turnos_delete_path(id: turno.id)
        end.to change(Turno, :count).by(-1)
      end
    end
  end
end
