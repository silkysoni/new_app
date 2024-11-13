class ShipmentController < ApplicationController
  def create
    @shipment = Shipment.new()
    @user = current_user

    if Shipment.save
      ShippingConfirmationMailer.with(user: @user).shipping_confirmation_email.deliver_later
    end
  end

  private
end
