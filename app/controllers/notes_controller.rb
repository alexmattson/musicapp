class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash[:errors] ||= []
      flash[:errors] += @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  def destroy
    @note= Note.find_by_id(params[:id])
    track_id = @note.track_id
    if @note.destroy
      flash[:errors] ||= []
      flash[:errors] += ["Note deleted successfully"]
      redirect_to track_url(track_id)
    else
      flash[:errors] ||= []
      flash[:errors] += @note.errors.full_messages
      redirect_to track_url(track_id)
    end
  end

  private
  def note_params
    params.require(:note).permit(:note, :track_id)
  end
end
