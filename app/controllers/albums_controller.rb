class AlbumsController < ApplicationController
  before_action :valid_view?

  def index
    @albums = Album.all
                   .joins("JOIN bands ON band_id = bands.id")
                   .order("bands.name, title")
                   .page params[:page]
  end

  def create
    @album = Album.new(album_params)
    @bands = Band.all
    @band = Band.find_by_id(@album.band_id)
    @route = tracks_url

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      render :new
    end
  end

  def new
    @album = Album.new
    @bands = Band.all
    @band = Band.find_by_id(params[:id])
    @route = albums_url
  end

  def show
    @album = Album.find_by_id(params[:id])
    @band = Band.find_by_id(@album.band_id)
    @tracks = @album.tracks
  end

  def destroy
    @album = Album.find_by_id(params[:id])
    @band = Band.find_by_id(@album.band_id)
    if @album.destroy
      flash[:errors] ||= []
      flash[:errors] += ["#{@album.title} deleted successfully"]
      redirect_to band_url(@band)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      render album_url(@album)
    end
  end

  def edit
    @album = Album.find_by_id(params[:id])
    @bands = Band.all
    @band = Band.find_by_id(@album.band_id)
    @route = album_url(@album)
  end

  def update
    @album = Album.find_by_id(params[:id])
    @bands = Band.all
    @band = Band.find_by_id(@album.band_id)
    @route = tracks_url

    if @album.update(album_params)
      redirect_to album_url(@update)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      render :edit
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :recording_type, :year)
  end
end
