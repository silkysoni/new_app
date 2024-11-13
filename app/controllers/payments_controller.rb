class PaymentsController < ApplicationController
  before_action :set_cart, only: [:create, :show, :new]
  before_action :ensure_address_present, only: [:create]

  def new
    @subtotal = params[:subtotal].to_f
  end

  def show
    @cart.ordered = true
    @cart.save
    ShippingConfirmationMailer.shipping_confirmation_email(current_user, @cart).deliver_later
    if params[:id] == "success"
      flash[:notice] = "Order placed Successfully!"
    else
      flash[:alert] = "Error in placing order!"
    end
    @cart_items = @cart.cart_items
    Rails.logger.debug("cartitems #{@cart_items.inspect}")
  end

  def create
    if @selected_address_id
      create_stripe_session
    else
      flash[:alert] = "Please choose an address before placing the order."
      redirect_to request.referer
    end
  end

  def create_stripe_session
    subtotal = 0
    quantity = 0

    @cart.cart_items.each do |item|
      subtotal += item.product.price * item.quantity
      quantity += item.quantity
    end

    @cart.address_id = @selected_address_id
    @cart.save!

    customer = Stripe::Customer.create(
      name: current_user.name,
      email: current_user.email,
      description: "Customer id: #{current_user.id}",
    )

    session = Stripe::Checkout::Session.create(
      customer: customer.id,
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "usd",
          product_data: {
            name: "Purchase",
          },
          unit_amount: subtotal.to_i,
        },
        quantity: quantity,
      }],
      mode: "payment"
      # success_url: success_payments_url(cart_id: @cart.id),
      # cancel_url: cancel_payments_url(cart_id: @cart.id),
    )
    redirect_to session.url, allow_other_host: true
  end

  private

  def set_cart
    @cart = current_user.carts.find(params[:cart_id])
  end

  def ensure_address_present
    addresses = Address.where(user_id: current_user.id)
    @selected_address_id = params[:selected_address]

    if addresses.blank?
      flash[:alert] = "Please add an address before placing the order."
      redirect_to edit_user_registration_path and return
    end
  end
end
