# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :request do
    descripcion { Faker::Lorem.sentence }
    association :user, factory: :user
    association :turno, factory: :turno
  end
end
