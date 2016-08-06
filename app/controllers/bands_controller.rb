class BandsController < ApplicationController
  before_action :valid_view?

  def index
    @bands = Band.all
                 .order("name")
                 .page params[:page]
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @band.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.new
    @route = bands_url
  end

  def show
    @band = Band.find_by_id(params[:id])
    @albums = @band.albums
  end

  def destroy
    @band = Band.find_by_id(params[:id])
    if @band.destroy
      flash[:errors] ||= []
      flash[:errors] += ["#{@band.name} deleted successfully"]
      redirect_to bands_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @band.errors.full_messages
      render band_url(@band)
    end
  end

  def edit
    @band = Band.find_by_id(params[:id])
    @route = band_url
  end

  def update
    @band = Band.find_by_id(params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @band.errors.full_messages
      render :edit
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
