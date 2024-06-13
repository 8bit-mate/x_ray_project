class Alias < ApplicationRecord
  belongs_to :artist
  belongs_to :related_artist, class_name: "Artist"
end
