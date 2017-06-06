class ProductsController < ApplicationController
  before_action :validate_search_key, only: [:search]   #  搜索功能

    def index
        @products = Product.all
    end
     def show
         @product = Product.find(params[:id])
     end
     #-------加入购物车--------
     def add_to_cart
       @product = Product.find(params[:id])
        @quantity = params[:quantity].to_i
        # 判断加入购物车的商品是否超过库存
         if @quantity > @product.quantity
           @quantity = @product.quantity
           flash[:warning] = "您选择的商品数量超过库存，实际加入购物车的商品为#{@quantity}件。"
         end
           current_cart.add(@product, @quantity)
           flash[:warning] = "商品已加入购物车"
       redirect_to :back
     end
    #  搜索功能
    def search
       if @query_string.present?
          search_result = Product.ransack(@search_criteria).result(:distinct => true)
          @products = search_result.paginate(:page => params[:page], :per_page => 5 )
        end
     end

     protected

       def validate_search_key
         @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
         @search_criteria = search_criteria(@query_string)
       end

       def search_criteria(query_string)
         { title_or_description_cont: query_string }
       end
    # # ----------------
end
