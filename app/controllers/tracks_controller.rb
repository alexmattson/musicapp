class TracksController < ApplicationController
  before_action :valid_view?

  def index
    @tracks = Track.all
                    .joins("JOIN albums on album_id = albums.id JOIN bands ON band_id = bands.id")
                    .order("bands.name, albums.title, tracks.ord")
                    .page params[:page]
  end

  def show
    @track = Track.find_by_id(params[:id])
    @album = Album.find_by_id(@track.album_id)
    @band = Band.find_by_id(@album.band_id)
    @notes = Note.where(track_id: @track.id).order("updated_at DESC")
    @note_route = notes_url
  end

  def create
    @track = Track.new(track_params)
    @albums = Album.all
    @album = Album.find_by_id(params[:track][:album_id])
    @band = Band.find_by_id(@album.band_id)
    @route = tracks_url

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @track.errors.full_messages
      render :new
    end
  end

  def new
    @track = Track.new
    @albums = Album.all
    @album = Album.find_by_id(params[:id])
    @band = Band.find_by_id(@album.band_id)
    @route = tracks_url
  end


  def destroy
    @track = Track.find_by_id(params[:id])
    @album = Album.find_by_id(@track.album_id)
    if @track.destroy
      flash[:errors] ||= []
      flash[:errors] += ["#{@track.name} deleted successfully"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @track.errors.full_messages
      render track_url(@track)
    end
  end

  def edit
    @track = Track.find_by_id(params[:id])
    @albums = Album.all
    @album = Album.find_by_id(@track.album_id)
    @band = Band.find_by_id(@album.band_id)
    @route = track_url(@track)
  end

  def update
    @track = Track.find_by_id(params[:id])
    @albums = Album.all
    @album = Album.find_by_id(@track.album_id)
    @band = Band.find_by_id(@album.band_id)
    @route = tracks_url

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @track.errors.full_messages
      render :edit
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :ord, :track_type, :lyrics)
  end
end
