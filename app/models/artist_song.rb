class ArtistSong < ApplicationRecord
  belongs_to :artist, counter_cache: :songs_count
  belongs_to :song
  belongs_to :role, optional: true
end
