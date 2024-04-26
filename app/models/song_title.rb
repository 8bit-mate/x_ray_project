class SongTitle < ApplicationRecord
  extend Mobility

  translates :title

  has_many :songs, dependent: :nullify
  after_destroy :handle_songs_after_destroy

  private

  def handle_songs_after_destroy
    default_title = SongTitle.find_or_create_by(title_en: "Unknown Title")

    Song.without_title.each do |song|
      song.song_title = default_title
      song.save
    end
  end
end
