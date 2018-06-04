class OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page]).per(10)
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
        redirect_to orders_path, notice: "new order created"
      else
        render "products/view_cart"
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
    flash[:alert] = "order was deleted"
  end

  private

  def order_params
    params.require(:order).permit(:name, :phone, :address)
  end

end