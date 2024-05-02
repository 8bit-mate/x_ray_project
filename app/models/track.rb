class Track < ApplicationRecord
  belongs_to :song

  has_one_attached :web_audio
end
