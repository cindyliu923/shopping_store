class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:edit, :update]

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def update
    if @order.update(order_params)
      if @order.payment_status == "paid" && @order.shipping_status == "shipped"
        UserMailer.notify_order_shipped(@order).deliver_now
      end
      if @order.payment_status == "paid" && @order.shipping_status == "not_shipped"
        UserMailer.notify_order_paid(@order).deliver_now
      end
      flash[:notice] = "order was successfully updated"
      redirect_to admin_orders_path
    else
      flash.now[:alert] = "order was failed to update"
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_status, :shipping_status)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
