# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :request do
    estado { %w[PENDIENTE ACEPTADO RECHAZADO].sample }
    descripcion { Faker::Lorem.sentence }
    association :user, factory: :user
    association :turno, factory: :turno
  end
end
