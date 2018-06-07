class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_cart

  private

  def after_sign_in_path_for(resource)
    # devise function for customize your redirect hook
    # if there is new order data in the session, go to form page
    if session[:new_order_data].present?
      @cart = Cart.find(session[:cart_id])
      view_cart_product_path(@cart)
    else
      # if there is no form data in session, proceed as normal
      super
    end
  end

  def current_cart
    @cart || set_cart
  end

  def set_cart
    if session[:cart_id]
      @cart = Cart.find_by(id: session[:cart_id])
    end

    @cart ||= Cart.create

    session[:cart_id] = @cart.id

    @cart  
  end

end
