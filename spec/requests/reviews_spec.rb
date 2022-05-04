require 'rails_helper.rb'
require 'faker'

# Se agrupan todos los tests relacionados al controlador de Profiles, con esta línea se le dice a Rails que será testeado
RSpec.describe Review, type: :request do

    # Aquí se utiliza la factory de Review para la creación de una publicación
    let!(:review) { create(:review) }
    let!(:attr_review){ {:title => Faker::Lorem.words(number: rand(10..20)), :content => Faker::Lorem.paragraph}}
    let!(:invalid_attr_review){ {:title => Faker::Lorem.words(number:1), :content => Faker::Lorem.paragraph}}
    # Se describe lo que se testea
    describe 'get index' do
        # Comportamiento esperado
        it 'should return a successful request' do
            # Se le señala a Rails que se haga un GET a la ruta /reviews
            get '/reviews'
            # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'get new' do
        it 'should return a successful request' do
            get '/reviews/new'
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'get_show' do
        it 'should return a successful request' do
            get "/review/#{review.id}"
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'create' do
        # La idea es que cuando yo cree una publicación la cuenta de publicaciones totales se incremente en 1
        it 'should increase count of Review by 1' do
            # Se espera que el bloque de código entregado cambie la cuenta de Publcation en 1 (al poner 1 es +1).
            expect {
            post '/reviews', params: {review: review.attributes}
            }.to change(Review, :count).by(1)
        end
        # Se pasan atributos invalidos y se ve que la cuenta de Publicaciones no cambie
        it 'should not increase count of Reviews' do
            expect {
            post '/reviews', params: {review: invalid_attr_review}
            }.to change(Review, :count).by(0)
        end
    end

    describe 'edit' do
        it 'should return a successful request' do
            get "/reviews/#{review.id}/edit"
            expect(response).to have_http_status(:ok)

        end
    end

    describe 'update' do
        it 'should change a Review' do
            expect{
            patch "/review/#{review.id}", params: {review: {:title => 'Ejemplo para cambiar'}}
            # Se recarga la instancia de review nuevamente con los posibles nuevos atributos
            # Luego se revisa si cambió alguno de los atributos del usuario
            review.reload
            }.to change(review, :title)

        end
    end
    # En este caso se trata de haer un update pero con atributos que no son válidos por las validaciones hechas.
    describe 'update' do
        it 'should not change a Review' do
            expect{
            patch "/review/#{review.id}", params: {review: {:content => 'hola', :title => 'example'}}
            # Se recarga la instancia de review nuevamente con los posibles nuevos atributos
            # Luego se revisa si cambió alguno de los atributos de la review
            review.reload
            }.to_not change(review, :attributes)

        end
    end


    describe 'delete' do
        it 'should decrease count of Review by 1' do
            expect{
            delete "/review/#{review.id}"
            }.to change(Review, :count).by(-1)

        end
    end

end 
