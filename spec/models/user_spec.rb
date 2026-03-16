require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with a name, email, and password' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a duplicate email' do
      create(:user, email: 'duplicate@example.com')
      user2 = build(:user, email: 'duplicate@example.com')
      expect(user2).not_to be_valid
    end
  end
end