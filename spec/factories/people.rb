FactoryBot.define do
  factory :message do
    id { SecureRandom.uuid }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
