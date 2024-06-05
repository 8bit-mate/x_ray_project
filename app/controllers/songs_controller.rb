class SongsController < ApplicationController
  # GET /songs or /songs.json
  def index
    # @songs = Song.all

    @q = filter_songs.ransack(params[:q])
    @q.sorts = "song_title_title" if @q.sorts.blank?
    @pagy, @songs = pagy(@q.result, anchor_string: 'data-turbo-stream="true"')
  end

  # GET /songs/1 or /songs/1.json
  def show
    @song = Song.friendly.find(params[:id])
  end

  private

  def filter_songs
    if params[:artist_id].present?
      artist = Artist.friendly.find(params[:artist_id])
      artist.songs
    elsif params[:song_title_id].present?
      song_title = SongTitle.find(params[:song_title_id])
      song_title.songs
    else
      Song.all
    end
  end
end
