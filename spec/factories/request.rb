require 'faker'

FactoryBot.define do
  factory :request do
    attr1{ value_for_attr_1 }
    attr2{ Faker::Name.name }
    attr3{ value_for_attr_3 }
  end
end