module Admin::SongsHelper
  def selected_artist_id(song, index)
    song.artists[index] ? song.artists[index].id : 0
  end

  def selected_role_id(song, index)
    song.artist_songs[index].role ? song.artist_songs[index].role.id : 0
  end

  def artists_count(song)
    song.artist_songs.count.positive? ? song.artist_songs.count : 1
  end

  def role_en_value(song, index)
    song.artist_songs[index] ? song.artist_songs[index].role_en : ""
  end

  def role_ru_value(song, index)
    song.artist_songs[index] ? song.artist_songs[index].role_ru : ""
  end
end
