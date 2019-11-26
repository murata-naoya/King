class Cart < ApplicationRecord

  belongs_to :product
  belongs_to :user

  # @total = 0
  # def cart_total(cart)
  #   @total += cart.product.price * cart.count
  # end
end
