require 'faker'

FactoryBot.define do
    factory :request do
      estado {['PENDIENTE','ACEPTADO','RECHAZADO'].sample}
      descripcion { Faker::Lorem.sentence}
      association :id_usuario_solicitud, factory: :user
      association :id_usuario, factory: :user
      association :id_publicacion, factory: :turno
    end
end