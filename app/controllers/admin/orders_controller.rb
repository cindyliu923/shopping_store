class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index

  end

end