class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    @products = Product.page(params[:page]).per(10)
    @products.each do |product|
      if product.stock == 0
        product.sell_status = "在庫なし"
        product.save
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    @discs = Product.find(params[:id]).discs
    @stock = @product.stock
    @review = @product.reviews.page(params[:page])
    if user_signed_in?
      @cart = Cart.find_by(product_id: @product.id, user_id: current_user.id)
      if @cart.blank?
        @cart = Cart.new
      end
    end
  end

  def search
    if params[:search].empty?
      @products = Product.all.order(created_at: :desc)
      @products = Product.page(params[:page]).per(10)
      render :index, locals: { products: @products}
    else
      @products = Product.order("created_at DESC").page(params[:page]).per(10).search(params[:search])
      render :index, locals: { products: @products}
    end
  end

end
