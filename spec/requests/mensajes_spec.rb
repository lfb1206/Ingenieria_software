# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mensajes', type: :request do

  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end
  let!(:user) { create(:user) }
  let!(:turno) { create(:turno) }
  let!(:mensaje) { create(:mensaje) }
  let!(:request) { create(:request) }
  let!(:invalid_attr_mensaje) { { contenido: nil } }

  describe 'GET /new' do
    it 'returns http success' do
      get mensajes_path(id_turno: 0)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create' do
    # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
    it 'should increase count of Request by 1' do
      # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
      expect do
        post mensajes_create_path(id: mensaje.id), params: { mensaje: mensaje.attributes }
      end.to change(Mensaje, :count).by(1)
    end
    # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
    it 'should not increase count of Request' do
      expect do
        invalid_attr_mensaje['turno_id'] = turno.id
        post mensajes_create_path(id: mensaje.id), params: { mensaje: invalid_attr_mensaje }
      end.to change(Mensaje, :count).by(0)
    end
  end
end
