class SongTitle < ApplicationRecord
  extend Mobility

  translates :title

  has_many :songs, dependent: :nullify

  after_destroy :update_songs_after_destroy
  after_update :update_songs_after_update

  scope :sort_by_title, ->(ord = :asc) { i18n.order(title: ord) }

  private

  def update_songs_after_update
    songs.each(&:update_full_title)
  end

  def update_songs_after_destroy
    default_title = SongTitle.find_or_create_by(title_en: "Unknown Title")

    Song.without_title.each do |song|
      song.song_title = default_title
      song.update_full_title
    end
  end
end
