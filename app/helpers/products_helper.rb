module ProductsHelper
  def print_product_title(product)
    if product.name?
        "Edit Product"
    else
        "Add New Product"
    end
  end
end
