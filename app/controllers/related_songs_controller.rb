class RelatedSongsController < ApplicationController
  def index
    @q = filter_songs.ransack(params[:q])
    @q.sorts = "title" if @q.sorts.blank?
    @pagy, @songs = pagy(@q.result, anchor_string: 'data-turbo-stream="true"')
  end

  private

  def filter_songs
    if params[:artist_id].present?
      artist = Artist.friendly.find(params[:artist_id])
      artist.songs
    elsif params[:song_group_id].present?
      song_group = SongGroup.find(params[:song_group_id])
      song_group.songs
    elsif params[:song_id].present?
      song = Song.friendly.find(params[:song_id])
      song_group = song.song_group
      song_group.songs.excluding(song)
    else
      Song.all
    end
  end
end
