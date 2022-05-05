require 'faker'

FactoryBot.define do
    factory :turno do
      id_usuario {Faker::Number.between(from: 1, to: 10000)}
      cantidad_asientos {Faker::Number.between(from: 1, to: 4)}
      hora_salida {Time.now()}
      direccion_salida {Faker::Address.full_address}
      direccion_llegada {Faker::Address.full_address}
      dia_semana {['Lunes','Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sabado'].sample}
      tipo {['Ida','Vuelta'].sample}
      estado {['ACTIVO','CONFIRMADO','COMPLETADO'].sample}
    end
end

