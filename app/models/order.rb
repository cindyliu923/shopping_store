class Order < ApplicationRecord
  validates_presence_of :name, :address, :phone, :payment_status, :shipping_status

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_many :payments, dependent: :destroy
  belongs_to :user

  def add_order_items(cart)
    cart.cart_items.each do |item|
      self.order_items.build(
        product_id: item.product.id,
        quantity: item.quantity, 
        price: item.product.price 
      )
    end
  end

  def show_payment_status
    if payment_status == "not_paid"
      "Not Paid"
    else
      "Paid"
    end
  end

  def show_shipping_status
    if shipping_status == "not_shipped"
      "Not Shipped"
    else
      "Shipped"
    end
  end
  
end
