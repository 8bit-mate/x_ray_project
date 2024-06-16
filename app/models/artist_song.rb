class ArtistSong < ApplicationRecord
  extend Mobility
  translates :role

  belongs_to :artist, counter_cache: :songs_count, optional: true
  belongs_to :song, optional: true

  accepts_nested_attributes_for :artist, allow_destroy: true
end
