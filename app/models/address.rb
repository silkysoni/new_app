class Address < ApplicationRecord
  belongs_to :user
  has_many :carts 

  validates :user, presence: true
  validate :user_address_limit
  validates :content, presence: true

  private

  def user_address_limit
    if user && user.addresses.count >= 3
      errors.add(:base, "cant be more than three.")
    end
  end
end
