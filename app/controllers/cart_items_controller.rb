class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update, :destroy]

  def index
  end

  def new
    @cart_item = CartItem.new
  end

  def create
    @cart_item = CartItem.create_or_update_cart_item(current_user, cart_params[:product_id])

    if @cart_item.persisted?
      flash[:notice] = "Product added to cart!"
      redirect_to product_path(cart_params[:product_id])
    else
      flash[:alert] = "Product not added to cart!"
      redirect_to product_path(cart_params[:product_id])
    end
  end

  def update
    if @cart_item.update_quantity(params[:quantity])
      render json: { message: "Quantity updated successfully." }, status: :ok
    else
      render json: { error: "Failed to update quantity." }, status: :unprocessable_entity
    end
  end

  def destroy
    is_cart_removed = CartItem.remove_from_cart(@cart_item.id)
    if is_cart_removed
      flash[:notice] = "Item removed from cart!"
    else
      flash[:alert] = "Error: Item not found or you do not have permission to remove it."
    end

    redirect_to carts_path
  end

  private

  def set_cart_item
    @cart_item = CartItem.find_by(id: params[:id])
    unless @cart_item
      flash[:alert] = "Item not found or you do not have permission to modify it."
      redirect_to carts_path
    end
  end

  def cart_params
    params.permit(:product_id)
  end
end
