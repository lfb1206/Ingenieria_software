# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :turno do
    id_usuario { Faker::Number.between(from: 1, to: 10_000) }
    cantidad_asientos { Faker::Number.between(from: 1, to: 4) }
    hora_salida { Time.now }
    direccion_salida { Faker::Address.full_address }
    direccion_llegada { Faker::Address.full_address }
    dia_semana { %w[Lunes Martes Miércoles Jueves Viernes Sabado].sample }
    tipo { %w[Ida Vuelta].sample }
    estado { %w[ACTIVO CONFIRMADO COMPLETADO].sample }
    association :user, factory: :user
  end
end
