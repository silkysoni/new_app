class ShippingConfirmationMailer < ApplicationMailer
    default from: "silky.s@cisinlabs.com"

    def shipping_confirmation_email(user, order)
    #   @user = params[:user]
      @user=user
      @order  = order 
      mail(to: @user.email, subject: "Your order has been plavced!")
    end
end
