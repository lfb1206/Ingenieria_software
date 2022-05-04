require 'rails_helper.rb'
require 'faker'
require 'factories/request'
require 'factories/user'
require 'factories/turno'

class RequestTest < ActiveSupport::TestCase

    # Se agrupan todos los tests relacionados al controlador de Profiles, con esta línea se le dice a Rails que será testeado
    RSpec.describe 'User', type: :user do

        # Aquí se utiliza la factory de Request para la creación de una publicación
        let(:user) {create(:user)}
        let(:user2) {create(:user)}

        describe 'get sign in' do
            it 'should return a successful request' do
                get '/users/sign_in'
                expect(response).to have_http_status(:ok)
            end
        end
        

        describe 'get sign up' do
            it 'should return a successful request' do
                get '/users/sign_up'
                expect(response).to have_http_status(:ok)
            end
        end
        end
end