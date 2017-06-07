class CartItemsController < ApplicationController
before_action :authenticate_user!
  def update_choose_staus

    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:notice] = "Update is_choosed"

    redirect_to carts_path
  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])

    if cart_item_params[:quantity].to_i >0 && @cart_item.product.quantity >= cart_item_params[:quantity].to_i
      if @cart_item.update(cart_item_params)
        flash[:notice] = "Update cart success"
      else
        flash[:warning] = "Update cart fail"
      end
    else
      flash[:warning] = "Unreasonable quantity"
    end
    redirect_to carts_path
  end

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
    @cart_item.destroy

    flash[:warning] = "Successfully delete #{@product.title}"
    redirect_to carts_path

  end

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
  private
  def cart_item_params
    params.require(:cart_item).permit(:is_choosed, :quantity)
  end
end
