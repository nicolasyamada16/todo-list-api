FactoryBot.define do
  random_password = Faker::Alphanumeric.alphanumeric(number: 18)

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { random_password }
    password_confirmation { random_password }
  end
end
