class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :budgets, dependent: :destroy

  validates :name, presence: true

  # app/models/user.rb
  def guest?
    false
  end

end
