class SongsController < ApplicationController
  # GET /songs or /songs.json
  def index
    # @songs = Song.all

    @q = Song.all.ransack(params[:q])
    @q.sorts = "song_title_title" if @q.sorts.blank?
    @pagy, @songs = pagy(@q.result)
  end

  # GET /songs/1 or /songs/1.json
  def show
    @song = Song.friendly.find(params[:id])
  end
end
