class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_order, only: [:edit, :update]

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def update
    if @order.update(order_params)
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
