require 'faker'

FactoryBot.define do
  factory :turno do
    cantidad_asientos{Faker::Number.between(from: 1, to: 15)}
    hora_salida{Faker::Time.between(from: 2.days.ago, to: Time.now, period: :day)}
    direccion_salida{Faker::Adress.addres}
    direccion_llegada{Faker::Adress.addres}
    dia_semana{Faker::randomElement(['Lunes',"Martes", "Miércoles", "Jueves", "Viernes", "Sabado"])}
    tipo{Faker::randomElement(['Ida',"Llegada"])}
    association :id_usuario, factory:user
  end
end