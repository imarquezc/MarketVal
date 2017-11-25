class ProductsController < ApplicationController
  def show #products/:id
    @product = Product.find(params[:id])
    respond_to do |format|
        format.json{render json: @product.to_json }
    end
  end

    
end
