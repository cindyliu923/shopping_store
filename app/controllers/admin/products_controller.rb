class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.page(params[:page]).per(5)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "product was successfully created"
      redirect_to admin_products_path
    else
      flash.now[:alert] = "product was failed to create"
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "product was successfully updated"
      redirect_to admin_products_path
    else
      flash.now[:alert] = "product was failed to update"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      redirect_to admin_products_path
      flash[:alert] = "product was deleted"
    else
      flash[:alert] = "Cannot delete product because dependent cart_items exist"
      redirect_to admin_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :image, :price, :description)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
