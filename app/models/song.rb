class Song < ApplicationRecord
  extend Mobility

  translates :notes

  has_many :artist_songs, dependent: :destroy
  has_many :artists, through: :artist_songs
end
