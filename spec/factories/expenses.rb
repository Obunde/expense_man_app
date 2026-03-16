FactoryBot.define do
  factory :expense do
    title { "Electricity Bill" }
    amount { 2500 }
    expense_date { Date.current }
    association :user
    association :category
  end
end