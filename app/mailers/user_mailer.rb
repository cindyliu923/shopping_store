class UserMailer < ApplicationMailer
  default from: "My Cart <cindy923liu@gmail.com>"

  def notify_order_create(order)
    @order = order
    @content = "Your order is created. Thank you!"

    mail to: order.user.email,
    subject: "Cindy Shopping store | 訂單成立: #{@order.id}"
  end

end
