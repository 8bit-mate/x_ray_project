class Song < ApplicationRecord
  extend Mobility

  translates :notes

  has_many :artist_songs, dependent: :destroy
  has_many :artists, through: :artist_songs

  def create_or_update_tags(tags_params)
    create_or_delete_artists(tags_params[:artists_ids])
  end

  private

  def create_or_delete_artists(artists_ids)
    artist_songs.destroy_all

    return unless artists_ids

    artists_ids.each do |id|
      artists << Artist.find_by(id:)
    end
  end
end
