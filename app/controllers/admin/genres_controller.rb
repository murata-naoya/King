class Admin::GenresController < ApplicationController
before_action :check_admin

  def index
  	@genres = Genre.with_discarded
  end

  def new
  	@genre = Genre.new
  end

  def create
  	@genre = Genre.new(genre_params)
  	if @genre.save
       flash[:notice] = "ジャンルが追加されました"
  	   redirect_to admin_genres_path
    else
      render "new"
    end
  end

  def edit
  	@genre = Genre.find(params[:id])
  end

  def update
  	@genre = Genre.find(params[:id])
  	if  @genre.update(genre_params)
        flash[:notice] = "ラベルが更新されました"
  	    redirect_to admin_genres_path
    else
        render "edit"
    end
  end

  def destroy
  	genre = Genre.find(params[:id])
    genre.products.each do |product|
      product.discard
    end
    genre.discard
  	redirect_to admin_genres_path
  end

  private
  def genre_params
  	params.require(:genre).permit(:name)
  end

end
