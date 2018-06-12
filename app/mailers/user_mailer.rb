class UserMailer < ApplicationMailer
  default from: "My Cart <cindy923liu@gmail.com>"

  def notify_order_create(order)
    @order = order
    @content = "Your order is created. Thank you!"

    mail to: order.user.email,
    subject: "Cindy Shopping store | 訂單成立: #{@order.id}"
  end

  def notify_order_shipped(order)
    @order = order
    @content = "We are pleased to inform you that your order has been shipped!"

    mail to: order.user.email,
    subject: "Cindy Shopping store | 訂單寄出: #{@order.id}"
  end

  def notify_order_paid(order)
    @order = order
    @content = "Your order has been paid."

    mail to: order.user.email,
    subject: "Cindy Shopping store | 訂單已付款: #{@order.id}"
  end

end
