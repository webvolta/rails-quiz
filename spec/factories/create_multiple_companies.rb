FactoryBot.define do
  factory :company do
    sequence(:id) { |n| n + 100 }
    name { Faker::Company.name }
  end
end
