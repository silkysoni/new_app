module ProductsHelper
  def format_price(price)
    number_to_currency(price, unit: "₹")
  end

  def calculate_subtotal(cart)
    number_to_currency(cart.cart_items.sum { |item| item.product.price * item.quantity },unit: "₹")
  end

end