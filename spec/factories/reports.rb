# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    usuario { Faker::Name.name }
    contenido { Faker::Lorem.sentence }
    association :user, factory: :user
  end
end
