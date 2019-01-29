class ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = current_cart.cart_items.find_by(product_id: @product)
  end

  def add_product_to_cart
    @product = Product.find(params[:id])
    current_cart.add_cart_item(@product)
    render :json => {
      :id => @product.id,
      :image => @product.image.url,
      :name => @product.name,
      :price => @product.price
    }
  end

  def remove_from_cart
    product = Product.find(params[:id])
    cart_item = current_cart.cart_items.find_by(product_id: product)
    cart_item.destroy
    render :json => { :id => product.id }
  end

  def add_cart_item_quantity
    product = Product.find(params[:id])
    cart_item = current_cart.cart_items.find_by(product_id: product)
    if cart_item.present?
      cart_item.quantity += 1
      cart_item.save!
      render :json => {
        :id => product.id,
        :quantity => cart_item.quantity
      }
    else
      render :json => {
        :id => product.id,
#        :quantity => cart_item.quantity
      }
    end
  end

  def minus_cart_item_quantity
    product = Product.find(params[:id])
    cart_item = current_cart.cart_items.find_by(product_id: product)
    if cart_item.present? && cart_item.quantity > 1
      cart_item.quantity -= 1
      cart_item.save!
      render :json => {
        :id => product.id,
        :quantity => cart_item.quantity
      }
    else
      render :json => {
        :id => product.id,
#        :quantity => cart_item.quantity
      }
    end
  end

  def view_cart
    if session[:new_order_data].present?
      @order = Order.new(session[:new_order_data])
    else
      @order = Order.new
    end
  end

end
