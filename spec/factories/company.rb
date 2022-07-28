FactoryBot.define do
  factory :company do
    name { Faker::Name.name }
  end
end
