require 'rails_helper.rb'
require 'faker'

# Se agrupan todos los tests relacionados al controlador de Profiles, con esta línea se le dice a Rails que será testeado
RSpec.describe Turno, type: :request do

    # Aquí se utiliza la factory de Turno para la creación de una publicación
    let!(:turno) { create(:turno) }
    let!(:attr_turno){ {:title => Faker::Lorem.words(number: rand(10..20)), :content => Faker::Lorem.paragraph}}
    let!(:invalid_attr_turno){ {:title => Faker::Lorem.words(number:1), :content => Faker::Lorem.paragraph}}
    # Se describe lo que se testea
    describe 'get index' do
        # Comportamiento esperado
        it 'should return a successful request' do
            # Se le señala a Rails que se haga un GET a la ruta /turnos
            get '/turnos'
            # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'get new' do
        it 'should return a successful request' do
            get '/turnos/new'
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'get_show' do
        it 'should return a successful request' do
            get "/turno/#{turno.id}"
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'create' do
        # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
        it 'should increase count of Turno by 1' do
            # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
            expect {
            post '/turnos', params: {turno: turno.attributes}
            }.to change(Turno, :count).by(1)
        end
        # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
        it 'should not increase count of Turnos' do
            expect {
            post '/turnos', params: {turno: invalid_attr_turno}
            }.to change(Turno, :count).by(0)
        end
    end

    describe 'edit' do
        it 'should return a successful request' do
            get "/turnos/#{turno.id}/edit"
            expect(response).to have_http_status(:ok)

        end
    end

    describe 'update' do
        it 'should change a Turno' do
            expect{
            patch "/turno/#{turno.id}", params: {turno: {:title => 'Ejemplo para cambiar'}}
            # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
            # Luego se revisa si cambió alguno de los atributos del usuario
            turno.reload
            }.to change(turno, :title)

        end
    end
    # En este caso se trata de haer un update pero con atributos que no son válidos por las validaciones hechas.
    describe 'update' do
        it 'should not change a Turno' do
            expect{
            patch "/turno/#{turno.id}", params: {turno: {:content => 'hola', :title => 'example'}}
            # Se recarga la instancia de turno nuevamente con los posibles nuevos atributos
            # Luego se revisa si cambió alguno de los atributos de la turno
            turno.reload
            }.to_not change(turno, :attributes)

        end
    end


    describe 'delete' do
        it 'should decrease count of Turno by 1' do
            expect{
            delete "/turno/#{turno.id}"
            }.to change(Turno, :count).by(-1)

        end
    end

end 
