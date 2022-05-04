require 'faker'

FactoryBot.define do
  factory :request do
    email{Faker::Internet.safe_email}
    encrypted_password{Faker::Internet.password(min_length: 6)}
    name{Faker::Name.first_name}
    address{Faker::Address.address}
    description{Faker::Lorem.sentence}
    gender{Faker::randomElement(['Femenino',"Masculino","Otro"])}
    phone{Faker::PhoneNumber.phone_number}
  end
end
