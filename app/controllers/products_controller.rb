class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    products = Product.all
    respond_to do |format|
      format.json{render json: products.to_json}
    end
  end
  def create
    product = Product.new(product_params)

    respond_to do |format|
      if product.save  
        msg = {id: product.id}
        format.json{render json: msg}
      else
        msg = {error: "An error has occurred, please try again"}
        format.json{render json: msg}
      end
    end
  end
  
  def show #products/:id
    product = Product.find(params[:id])
    respond_to do |format|
        format.json{render json: product.to_json }
    end
  end

  
  private
  def product_params
    params.require(:product).permit(:name,:description,:price,:stock,:owner_store)
  end
end
