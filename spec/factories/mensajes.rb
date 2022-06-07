# frozen_string_literal: true

FactoryBot.define do
  factory :mensaje do
    contenido { Faker::Lorem.sentence }
    association :user, factory: :user
    association :turno, factory: :turno
  end
end
