FactoryBot.define do
  factory :user do
    name { "Eugene Test" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    admin { false }

    trait :admin do
      admin { true }
      name { "Admin User" }
    end
  end
end