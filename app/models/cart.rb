class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items, dependent: :destroy
  belongs_to :address, optional: true

  scope :ordered, -> { order(created_at: :desc) }
  scope :items, ->(data){ where(ordered: data)}

  validates :user, presence: true

  def add_or_update_item(product_id, quantity)
    cart_item = cart_items.find_by(product_id: product_id)

    if cart_item
      cart_item.update_quantity(quantity)
    else
      cart_items.create(product_id: product_id, quantity: quantity, total: calculate_total(product_id, quantity))
    end

    update_cart_subtotal
    cart_item
  end

  def calculate_total(product_id, quantity)
    product = products.find(product_id)
    product.price * quantity
  end

  def update_cart_subtotal
    subtotal = cart_items.sum(:total)
    update(subtotal: subtotal)
  end
end
