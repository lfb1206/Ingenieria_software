require 'rails_helper.rb'
require 'faker'

# Se agrupan todos los tests relacionados al controlador de Profiles, con esta línea se le dice a Rails que será testeado
RSpec.describe Message, type: :request do

    # Aquí se utiliza la factory de Message para la creación de una publicación
    let!(:message) { create(:message) }
    let!(:attr_message){ {:title => Faker::Lorem.words(number: rand(10..20)), :content => Faker::Lorem.paragraph}}
    let!(:invalid_attr_message){ {:title => Faker::Lorem.words(number:1), :content => Faker::Lorem.paragraph}}
    # Se describe lo que se testea
    describe 'get index' do
        # Comportamiento esperado
        it 'should return a successful request' do
            # Se le señala a Rails que se haga un GET a la ruta /messages
            get '/messages'
            # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'get new' do
        it 'should return a successful request' do
            get '/messages/new'
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'get_show' do
        it 'should return a successful request' do
            get "/message/#{message.id}"
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'create' do
        # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
        it 'should increase count of Message by 1' do
            # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
            expect {
            post '/messages', params: {message: message.attributes}
            }.to change(Message, :count).by(1)
        end
        # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
        it 'should not increase count of Messages' do
            expect {
            post '/messages', params: {message: invalid_attr_message}
            }.to change(Message, :count).by(0)
        end
    end

    describe 'edit' do
        it 'should return a successful request' do
            get "/messages/#{message.id}/edit"
            expect(response).to have_http_status(:ok)

        end
    end

    describe 'update' do
        it 'should change a Message' do
            expect{
            patch "/message/#{message.id}", params: {message: {:title => 'Ejemplo para cambiar'}}
            # Se recarga la instancia de message nuevamente con los posibles nuevos atributos
            # Luego se revisa si cambió alguno de los atributos del usuario
            message.reload
            }.to change(message, :title)

        end
    end
    # En este caso se trata de haer un update pero con atributos que no son válidos por las validaciones hechas.
    describe 'update' do
        it 'should not change a Message' do
            expect{
            patch "/message/#{message.id}", params: {message: {:content => 'hola', :title => 'example'}}
            # Se recarga la instancia de message nuevamente con los posibles nuevos atributos
            # Luego se revisa si cambió alguno de los atributos de la message
            message.reload
            }.to_not change(message, :attributes)

        end
    end


    describe 'delete' do
        it 'should decrease count of Message by 1' do
            expect{
            delete "/message/#{message.id}"
            }.to change(Message, :count).by(-1)

        end
    end

end 
