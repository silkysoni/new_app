class CartItem < ApplicationRecord
  belongs_to :cart 
  belongs_to :product
  
  validates :product_id, presence:true 
  validates :total , presence:true 

  def self.create_or_update_cart_item(user, product_id)
    cart_item = find_or_initialize_by(product_id: product_id, user: user)
    cart_item.quantity = cart_item.new_record? ? 1 : cart_item.quantity + 1
    cart_item.save
    cart_item
  end

  def update_quantity(quantity)
    self.quantity += quantity
    self.total = cart.calculate_total(product_id, self.quantity)
    save
  end

  def self.remove_from_cart(cart_item_id)
    cart_item = find_by(id: cart_item_id)
    # &. shorthand for “call this method only if the object is not nil”
    cart_item&.destroy
    cart_item
  end
end
