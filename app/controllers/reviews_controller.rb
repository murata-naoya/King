class ReviewsController < ApplicationController
before_action :check_user

  def new
  	@review = Review.new
  	@product = Product.find(params[:product_id])
  end

  def create
  	@product = Product.find(params[:product_id])
  	@review = Review.new(review_params)
  	@review = current_user.review.new(review_params)
  	@review.product_id = @product.id
  	if @review.save
       flash[:notice] = "レビューが作成されました!"
  	   redirect_to product_path(product)
    else
       render "new"
    end
  end

  def edit
  	@review = Review.find(params[:id])
  end

  def update
  	@review = Review.find(params[:id])
  	if @review.update(review_params)
       flash[:notice] = "レビューが更新されました!"
  	   redirect_to product_path(@review.product)
    else
       render "edit"
    end
  end

  def destroy
  	@review = Review.find(params[:id])
  	@review.destroy
  	redirect_to product_path(@review.product)
  end

  private
  def review_params
  	params.require(:review).permit(:review, :user_id, :product_id)
  end
end
