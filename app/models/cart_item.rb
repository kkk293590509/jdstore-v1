class CartItem < ApplicationRecord
     belongs_to :cart
     belongs_to :product
   def add_quantity
      @cart_item = current_cart.cart_items.find_by_product_id(params[:id])
      if @cart_item.quantity < @cart_item.product.quantity
           @cart_item.quantity += 1
           @cart_item.save
           redirect_to carts_path
      elsif @cart_item.quantity == @cart_item.product.quantity
           redirect_to carts_path, alert: "库存不足！"
      end
    end

    def remove_quantity
      @cart_item = current_cart.cart_items.find_by_product_id(params[:id])
      if @cart_item.quantity > 0
           @cart_item.quantity -= 1
           @cart_item.save
           redirect_to carts_path
      elsif @cart_item.quantity == 0
           redirect_to carts_path, alert: "商品不能少于零！"
      end
    end
end
