class Artist < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  has_many :artist_songs, dependent: :destroy
  has_many :songs, through: :artist_songs

  after_update :update_associated_songs_full_titles

  private

  def update_associated_songs_full_titles
    songs.each(&:update_full_title)
  end
end
