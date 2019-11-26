class Admin::ArrivalsController < ApplicationController
before_action :check_admin

  def new
  	@arrival = Arrival.new
  end

  def create
  	@arrival = Arrival.new(arrival_params)
  	if @arrival.save
  		flash[:notice] = "入荷情報が登録されました"
      @product = Product.find(arrival_params[:product_id])
      @product.sell_status = "在庫あり"
      @product.save
  		redirect_to admin_products_path
  	else
  		render "new"
  	end
  end

  def index
	@arrivals = Arrival.all
  end

  	private
  	def arrival_params
  		params.require(:arrival).permit(:product_id, :arrival_count, :arrival_date)
    end
end
