class CartsController < ApplicationController
before_action :check_user

  def index
    @carts = current_user.carts
  end

  def create
    product = Product.find(params[:product_id])
    cart = current_user.carts.new(cart_params)
    cart.product_id = product.id
    cart.save
    redirect_to carts_path
   end

  def change
    cart = Cart.find(params[:id])
    cart.count += cart_params[:count].to_i
     cart.save
     redirect_to carts_path
  end

  def update
    cart = Cart.find(params[:id])
    if cart_params[:count].to_i == 0
       cart.destroy
       flash[:notice] = "カートから外しました"
       redirect_to carts_path
    elsif cart.product.stock >= cart_params[:count].to_i
       cart.update(cart_params)
       redirect_to carts_path
    else
        @carts = current_user.carts
        render "index"
    end
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    redirect_to carts_path
  end

private
  def cart_params
    params.require(:cart).permit(:count)
  end

end
