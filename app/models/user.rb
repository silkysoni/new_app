class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, reject_if: proc { |attributes| attributes["content"].blank? }

  has_many :carts
  has_many :cart_items
  has_many :wishlist_items
  has_many :reviews

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  private
  
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
