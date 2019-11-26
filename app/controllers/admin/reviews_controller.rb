class Admin::ReviewsController < ApplicationController
before_action :check_admin

  def new
  end

  def edit
  	@review = Review.find(params[:id])
  end

  def update
  	@review = Review.find(params[:id])
  	if @review.update(review_params)
       flash[:notice] = "レビューが作成されました!"
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

  def _index
  end
end
