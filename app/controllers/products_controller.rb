class ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
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

end
