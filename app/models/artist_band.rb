class ArtistBand < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :band, class_name: "Artist", optional: true
end
