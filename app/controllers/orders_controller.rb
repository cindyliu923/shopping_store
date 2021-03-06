class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :create

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    if current_user.nil?
      session[:new_order_data] = params[:order]
      redirect_to new_user_session_path
    else
      @order = current_user.orders.new(order_params)
      @order.sn = Time.now.to_i
      @order.add_order_items(current_cart)
      @order.amount = current_cart.subtotal
      if @order.save
        current_cart.destroy
        session.delete(:new_order_data)
        UserMailer.notify_order_create(@order).deliver_now!
        redirect_to orders_path, notice: "new order created"
      else
        render "products/view_cart"
      end
    end
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.shipping_status == "not_shipped"
      @order.shipping_status = "cancelled"
      @order.save
      redirect_to orders_path, alert: "order##{@order.sn} cancelled."
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone, :address)
  end

end