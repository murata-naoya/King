require "user.rb"

class OrderItemsController < ApplicationController
before_action :check_user

  def index
    if current_user.destinations.blank?
      @destination = current_user.destinations.new
      @destination.address_name = current_user.full_name(current_user)
      @destination.postal_code = current_user.postal_code
      @destination.address = current_user.address
      @destination.phone_number = current_user.phone_number
      @destination.save
    else
      @destination = Destination.find_by(user_id: current_user.id)
    end
  end

  def create
    carts = current_user.carts
    if carts.blank?
      flash[:notice] = "カートに中身がありません"
      redirect_to carts_path
    else
        carts.each do |cart|
          order_item = OrderItem.find_by(product_id: cart.product_id, order_id: 0)
          # cart_order_items = order_items.find_all{|order_item| order_item.product_id == cart.product_id}
          if order_item.nil? #存在しなかったら
            order_item = OrderItem.new
            order_item.product_id = cart.product_id
            order_item.count = cart.count
            order_item.price = cart.product.price
            order_item.order_id = 0
            order_item.save
          else  #それ以降の挙動
            order_item.count = cart.count
            order_item.price = cart.product.price
            order_item.save
          end
        end
      redirect_to order_items_path
    end
  end

  def destroy

  end

  def final
    @destination = Destination.find_by(user_id: current_user.id)
    @order = Order.new
  end


end
