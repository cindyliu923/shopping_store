class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @orders = Order.page(params[:page]).per(10)
  end

end
