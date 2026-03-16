require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category, name: 'Food', user: user) }

  describe 'Validations' do
    it 'is valid with all required fields' do
      expense = build(:expense, title: 'Lunch', amount: 500, expense_date: Date.today, user: user, category: category)
      expect(expense).to be_valid
    end

    it 'is invalid if amount is 0 or negative' do
      expense = build(:expense, title: 'Lunch', amount: 0, user: user, category: category)
      expense.valid?
      expect(expense.errors[:amount]).to include("must be greater than 0")
    end

    it 'is invalid without an expense_date' do
      expense = build(:expense, expense_date: nil)
      expense.valid?
      expect(expense.errors[:expense_date]).to include("can't be blank")
    end
  end
end