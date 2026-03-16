FactoryBot.define do
  factory :budget do
    monthly_limit { 50000 }
    month { Date.current.month }
    year { Date.current.year }
    association :user
  end
end