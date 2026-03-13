class Budget < ApplicationRecord
  belongs_to :user

  validates :monthly_limit, presence: true, numericality: { greater_than: 0 }
  validates :month, presence: true, numericality: { only_integer: true, in: 1..12 }
  validates :year, presence: true, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: [:month, :year], message: "already has a budget for this month" }
  
end
