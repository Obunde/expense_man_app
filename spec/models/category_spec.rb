require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create(:user) }

  describe 'Validations' do
    it 'is valid with a name and a user' do
      category = build(:category, name: 'Groceries', user: user)
      expect(category).to be_valid
    end

    it 'is invalid without a name' do
      category = build(:category, name: nil, user: user)
      category.valid?
      expect(category.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a user' do
      category = build(:category, name: 'Groceries', user: nil)
      category.valid?
      expect(category.errors[:user]).to include("must exist")
    end
  end
end
