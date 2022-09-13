FactoryBot.define do
  factory :company do
    id { SecureRandom.uuid }
    name { Faker::Name.name }
  end
end
