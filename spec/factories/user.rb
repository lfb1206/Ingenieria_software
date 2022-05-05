# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { 'password' }
    password_confirmation { 'password' }
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    description { Faker::Lorem.sentence }
    gender { Faker::Gender.binary_type }
    phone { Faker::Number.between(from: 10_000_000, to: 99_999_999) }
  end
end
