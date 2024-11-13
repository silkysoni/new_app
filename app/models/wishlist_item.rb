class WishlistItem < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :products 

  def self.add_or_remove_from_wishlist(user, product_id)
    item = user.wishlist_items.find_or_initialize_by(product_id: product_id)

    if item.new_record?
      item.save
    else
      item.destroy
    end
    item
  end

  def remove_item(id)
    item = find_by(id)
    item&.destroy 
    item
  end
 

end
