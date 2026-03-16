require 'rails_helper'

RSpec.describe Budget, type: :model do
  let(:user) { create(:user) }

  describe 'Validations' do
    it 'is valid with proper month, year, and limit' do
      budget = build(:budget, monthly_limit: 50000, month: 3, year: 2026, user: user)
      expect(budget).to be_valid
    end

    it 'is invalid if the month is outside 1..12' do
      budget = build(:budget, month: 13, user: user)
      budget.valid?
      expect(budget.errors[:month]).to include("must be in 1..12")
    end

    it 'is invalid if a user creates a second budget for the same month and year' do
      create(:budget, monthly_limit: 1000, month: 3, year: 2026, user: user)
      duplicate = build(:budget, monthly_limit: 2000, month: 3, year: 2026, user: user)
      
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:user_id]).to include("already has a budget for this month")
    end
  end
end