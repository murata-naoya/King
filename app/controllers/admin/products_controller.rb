class Admin::ProductsController < ApplicationController
before_action :check_admin

  def new
  	@product = Product.new
  	@disc = @product.discs.build
  	@song = @disc.songs.build
  end

  def create
  	@product = Product.new(product_params)
	  if @product.save
  		flash[:notice] = "商品が登録されました"
  		redirect_to admin_products_path
  	else
  		render "new"
  	end
  end

  def index
  	@products = Product.with_discarded
    @products.each do |product|
      if product.stock == 0
        product.sell_status = "在庫なし"
        product.save
      end
    end
  end

  def show
  	@product = Product.with_discarded.find(params[:id])
  	@discs = Product.with_discarded.find(params[:id]).discs
    @stock = @product.stock
  end

  def edit
  	@product = Product.find(params[:id])
  end

  def update
  	@product = Product.find(params[:id])
  	if @product.update(product_params)
  		flash[:notice] = "商品情報を更新しました"
  		redirect_to admin_product_path(@product)
  	else
  		render "edit"
  	end
  end

  def destroy
  	product = Product.find(params[:id])
	  product.discard
  	redirect_to admin_products_path
  end

  private
  def product_params
  	params.require(:product).permit(:product_name,:cd_type, :artist_id, :jacket_image, :price, :label_id, :genre_id, :stock, :sell_status, :sold_at,
  	 discs_attributes: [:id, :cd_count, :product_id, :_destroy,
  	 songs_attributes: [:id, :song_order, :name, :disc_id, :_destroy]])
  end
end
