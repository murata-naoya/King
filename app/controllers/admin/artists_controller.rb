class Admin::ArtistsController < ApplicationController
before_action :check_admin

  def index
  	@artists = Artist.with_discarded
  end

  def new
  	@artist = Artist.new
  end

  def create
  	@artist = Artist.new(artist_params)
  	if @artist.save
  	   flash[:notice] = "アーティストが追加されました"
  	   redirect_to admin_artists_path
  	else
  		render "new"
  	end
  end

  def edit
  	@artist = Artist.find(params[:id])
  end

  def update
  	@artist = Artist.find(params[:id])
  	if  @artist.update(artist_params)
  		flash[:notice] = "アーティストが更新されました"
  		redirect_to admin_artists_path
  	else
  		render "edit"
  	end
  end

  def destroy
  	artist = Artist.find(params[:id])
    artist.products.each do |product|
      product.discard
    end
	  artist.discard
  	redirect_to admin_artists_path
  end

  private
  def artist_params
  	params.require(:artist).permit(:name)
  end
end
