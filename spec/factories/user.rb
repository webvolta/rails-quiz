FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n + 100 }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
