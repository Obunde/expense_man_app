FactoryBot.define do
  factory :category do
    name { "Utilities" }
    association :user # Automatically creates a user if one isn't provided
  end
end