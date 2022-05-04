require 'faker'

FactoryBot.define do
    factory :turno do
      cantidad_asientos {Faker::Number.between(from: 1, to: 4)}
      hora_salida {'13:43'}
      direccion_salida {Faker::Address.full_address}
      direccion_llegada {Faker::Address.full_address}
      dia_semana {['Lunes',"Martes", "Miércoles", "Jueves", "Viernes", "Sabado"].sample}
      tipo {['Ida',"Vuelta"].sample}
      association :id_usuario, factory: :user
    end
end