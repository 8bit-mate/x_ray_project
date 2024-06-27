class SongsController < ApplicationController
  # GET /songs or /songs.json
  def index
    @q = Song.all.ransack(params[:q])
    @q.sorts = "title" if @q.sorts.blank?
    @pagy, @songs = pagy(@q.result, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /songs/1 or /songs/1.json
  def show
    @song = Song.friendly.find(params[:id])
  end
end
