FactoryBot.define do
  factory :person do
    sequence(:name) { |n| "Person #{n}" }
    phone_number  { "123456" }
    email { "email@gmail.com" }

    association :company
  end
end
