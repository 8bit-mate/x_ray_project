class SongGroup < ApplicationRecord
  extend Mobility

  validates :title_en, presence: true
  validates :title_ru, presence: true

  translates :title

  has_many :songs, dependent: :nullify

  after_destroy :update_songs_after_destroy
  after_update :update_songs_after_update

  def self.ransackable_attributes(_auth_object = nil)
    %w[title title_en title_ru]
  end

  private

  def update_songs_after_update
    songs.each(&:update_full_title)
  end

  def update_songs_after_destroy
    default_title = SongGroup.find_or_create_by(title_en: "Unknown Title")

    Song.without_title.each do |song|
      song.song_group = default_title
      song.update_full_title
    end
  end
end
