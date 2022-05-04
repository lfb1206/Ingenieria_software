require 'rails_helper.rb'


# Se agrupan todos los tests relacionados al controlador de Users, con esta línea se le dice a Rails que será testeado
RSpec.describe "Users", type: :request do
    # Se crean unos atributos para la creación de un User 
    # para ver si es que funciona bien algunas características en donde se necesita que el usuario sea guardado
    before(:each) {
        @attr_user = {
        :name => 'Example_name', 
        :description => 'Exampple description',
        :email => 'test@test.com', 
        :work => 'example work',
        :age => 20
        }

        @invalid_attr_user = {
            :name => 'Example_name', 
            :description => 'Exampple description',
            :email => 'test@test.com', 
            :work => 'example work',
            :age => 'hola'
        }
        @attr_user2 = {
            :name => 'Example_name_2', 
            :description => 'Exampple description',
            :email => 'test@test.com', 
            :work => 'example work',
            :age => 25
        }
    }
    # Se describe lo que se testea
    describe 'get index' do
        # Comportamiento esperado
        it 'should return a successful request' do
            # Se le señala a Rails que se haga un GET a la ruta /users
            get '/users'
            # Lo esperado es que la respuesta tenga un status ok o 200 que representa que todo ha salido bien
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'get_new' do
        it 'should return a successful request' do
            get '/users/new'
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'get_show' do
        it 'should return a successful request' do
            # Se crea una instancia de User
            @user = User.create!(@attr_user)
            # Se realiza un GET con el id del user recién creado y se espra que la salida sea un 200 que es lo mismo que un ok
            get "/user/#{@user.id}"
            expect(response).to have_http_status(:ok)
        end
    end

    describe 'create' do
        # La idea es que cuando yo cree un usuario la cuenta de usuario totales se incremente en 1
        it 'should increase count of Users by 1' do
            # Se espera que el bloque de código entregado cambie la cuenta de User en 1 (al poner 1 es +1).
            expect {
            post '/users', params: {user: @attr_user}
            }.to change(User, :count).by(1)
        end
        # No debería aumentar la cuenta porque le estamos pasando un atributo inválido según las validaciones que se hicieron
        it 'should not increase count of Users' do
            expect {
            post '/users', params: {user: @invalid_attr_user}
            }.to change(User, :count).by(0)
        end
    end

    describe 'edit' do
        it 'should return a successful request' do
            @user = User.create!(@attr_user)
            get "/users/#{@user.id}/edit"
            expect(response).to have_http_status(:ok)

        end
    end

    describe 'update' do
        it 'should change a User' do
            # Se crea el perfil donde se testeará el update
            @user = User.create!(@attr_user)

            expect{
            patch "/user/#{@user.id}", params: {user: {:age => 40}}
            # Se recarga la instancia de profiele nuevamente con los posibles nuevos atributos
            @user.reload
            # Luego se revisa si cambió alguno de los atributos del usuario
            }.to change(@user, :attributes)

        end
    end

    describe 'update' do
        it 'should not change a User' do
            # Se crea el perfil donde se testeará el update
            @user = User.create!(@attr_user)

            expect{
            # Se realiza un patch dado que es de actualización de un usuario ya creado
            patch "/user/#{@user.id}", params: {user: @invalid_attr_user}
            # Se recarga la instancia de profiele nuevamente con los posibles nuevos atributos
            # Luego se revisa si cambió alguno de los atributos del usuario
            @user.reload
            }.to_not change(@user, :attributes)

        end
    end


    describe 'delete' do
        it 'should decrease count of Users by 1' do
            # Se crea el perfil donde se testeará el update
            @user = User.create!(@attr_user)
            expect{
            delete "/user/#{@user.id}"
            }.to change(User, :count).by(-1)

        end
    end

end 