FactoryBot.define do
  factory :mensaje do
    contenido { "MyString" }
    user { nil }
    turno { nil }
  end
end
