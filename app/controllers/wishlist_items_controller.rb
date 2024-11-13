class WishlistItemsController < ApplicationController
  before_action :set_wishlist
  def index
    @wishlist_items = @wishlist.order(created_at: :desc)
  end

  def create
    product_id = params[:product_id]
    @wish_list_item = WishlistItem.add_or_remove_from_wishlist(current_user,product_id)

    if @wish_list_item.persisted?
      flash[:notice] = "Added to wishlist!"
      redirect_to request.referer
    else
      flash[:notice] = "Removed from wishlist!"
      redirect_to request.referer
    end
  end

  def destroy
    if WishlistItem.remove_item(params[:id])
      flash[:notice] = "Item removed from wishlist!"
    else
      flash[:alert] = "Error: Item not found or you do not have permission to remove it."
    end
    redirect_to wishlist_items_path
  end

  private 
  def set_wishlist
    @wishlist= current_user.wishlist_items
  end
end
