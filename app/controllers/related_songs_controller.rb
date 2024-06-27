class RelatedSongsController < ApplicationController
  def index
    @q = filter_songs.ransack(params[:q])
    @q.sorts = "title" if @q.sorts.blank?
    @pagy, @songs = pagy(@q.result, anchor_string: 'data-turbo-stream="true"')
  end

  private

  def filter_songs
    if params[:artist_id].present?
      find_songs_by_artist
    elsif params[:song_group_id].present?
      find_songs_by_song_group
    elsif params[:song_id].present?
      find_songs_by_primary_song
    else
      Song.all
    end
  end

  def find_songs_by_artist
    artist = Artist.friendly.find(params[:artist_id])
    artist.songs
  end

  def find_songs_by_song_group
    song_group = SongGroup.find(params[:song_group_id])
    song_group.songs
  end

  def find_songs_by_primary_song
    song = Song.friendly.find(params[:song_id])
    song_group = song.song_group
    song_group.songs.excluding(song)
  end
end
