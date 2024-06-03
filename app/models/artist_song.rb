class ArtistSong < ApplicationRecord
  belongs_to :artist, counter_cache: :songs_count
  belongs_to :song
end
