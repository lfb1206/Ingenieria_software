require 'faker'

FactoryBot.define do
    factory :user do
      email {Faker::Internet.safe_email}
      password {'password'}
      password_confirmation  {'password'}
      name {Faker::Name.name}
      address {Faker::Address.full_address}
      description {Faker::Lorem.sentence}
      gender {Faker::Gender.binary_type}
      phone {Faker::Number.between(from: 10000000, to: 99999999)}
    end
end
 