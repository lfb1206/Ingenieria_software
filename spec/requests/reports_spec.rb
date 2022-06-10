# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end
  let!(:report) { create(:report) }
  let!(:invalid_attr_report) { { contenido: nil } }

  describe 'GET /new' do
    it 'returns http success' do
      get '/reports/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'get_show' do
    it 'should return a successful request' do
      get reports_show_path(id: report.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'create' do
    # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
    it 'should increase count of Request by 1' do
      # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
      expect do
        post reports_create_path(id: report.id), params: { report: report.attributes }
      end.to change(Report, :count).by(1)
    end
    # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
    it 'should not increase count of Request' do
      expect do
        post reports_create_path(id: report.id), params: { report: invalid_attr_report }
      end.to change(Report, :count).by(0)
    end
  end
end
