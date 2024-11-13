class CartsController < ApplicationController
  before_action :set_cart, only: [:index, :invoice]
  before_action :set_carts, only: [:index, :ordered_items, :create, :invoice]

  def index
    @user=current_user
    @cart = @carts.items(false).ordered.first
  end

  def show
  end

  def ordered_items
    @ordered_carts = @carts.items(true).ordered.page(params[:page])
  end

  def create
    product_id = params[:product_id] || params[:cartitem_id]
    quantity = params[:quantity].to_i > 0 ? params[:quantity].to_i : 1
    cart = @carts.find_or_create_by(ordered: false)

    cart_item = cart.add_or_update_item(product_id, quantity)

    remove_from_wishlist if params[:cartitem_id]

    flash[:notice] = "Product added to cart." 
    redirect_to carts_path(cart_item)
  end

  def invoice
    @cart = @carts.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Carts: #{@cart.id}",
               template: "carts/invoice",
               formats: [:html],
               disposition: :inline,
               layout: "pdf"
      end
    end
  end

  private

  def remove_from_wishlist
    id = params[:cartitem_id]
    wishlist_item = current_user.wishlist_items.find_by(product_id: id)
    wishlist_item.destroy if wishlist_item
  end

  def set_cart
    @cart = current_user.carts.find_or_create_by(ordered: false)
  end

  def set_carts
    @carts = current_user.carts
  end

  def cart_params
    params.require(:cart).permit(:subtotal, cart_items_attributes: [:id, :quantity])
  end
end
