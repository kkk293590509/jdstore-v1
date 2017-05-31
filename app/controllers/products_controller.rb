class ProductsController < ApplicationController
    def index
        @products = Product.all
     end

     def show
       if params[:id].to_i>1
         @product = Product.find(params[:id])
       end
     end

     def add_to_cart
       @product = Product.find(params[:id])
       current_cart.add_product_to_cart(@product)
       flash[:notice] = "成功加入购物车"
       redirect_to :back
    end
end
