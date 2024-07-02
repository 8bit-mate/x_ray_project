class ArtistBand < ApplicationRecord
  extend Mobility

  translates :role

  belongs_to :artist, optional: true
  belongs_to :band, class_name: "Artist", optional: true
end
