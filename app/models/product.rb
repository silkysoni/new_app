class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :sub_category

  has_many :wishlist_items
  has_many :cart_items
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  scope :order_price_by_asc, -> { order(price: :asc) }

  scope :category, ->{joins(sub_category: :category)
  .where(sub_categories: { category_id: category.id })
  .includes(:sub_category)}
  
end
