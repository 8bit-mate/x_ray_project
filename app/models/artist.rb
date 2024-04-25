class Artist < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  has_many :artist_songs, dependent: :destroy
  has_many :songs, through: :artist_songs
end
