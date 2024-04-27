class Song < ApplicationRecord
  extend Mobility
  extend FriendlyId

  friendly_id :compose_slug_title, use: :slugged

  scope :without_title, -> { where(song_title: nil) }
  scope :with_full_title, ->(title) { where(full_title: title) }

  translates :notes

  has_many :artist_songs, dependent: :destroy
  has_many :artists, through: :artist_songs

  belongs_to :song_title

  def create_or_update_tags(tags_params)
    create_or_delete_artists(tags_params[:artists_ids])
    create_or_delete_song_title(tags_params[:song_title_id])

    self.full_title = compose_full_title
  end

  def list_artists = artists.order(:last_name_en).map(&:full_name).join("; ")

  def human_full_title
    "#{list_artists} - #{song_title.title}"
  end

  def should_generate_new_friendly_id?
    full_title_changed? || slug.blank?
  end

  def update_full_title
    self.full_title = compose_full_title
    save
  end

  private

  def compose_slug_title
    n_songs_with_this_title = Song.with_full_title(full_title).length
    n_songs_with_this_title.zero? ? full_title : "#{full_title}-#{n_songs_with_this_title}"
  end

  def compose_full_title
    names = artists.map(&:full_name).join(" ")
    title = song_title.title_en
    "#{names}-#{title}"
  end

  def create_or_delete_song_title(id)
    return if id.nil?

    self.song_title = SongTitle.find_by(id:)
  end

  def create_or_delete_artists(artists_ids)
    artist_songs.destroy_all

    return unless artists_ids

    artists_ids.each do |id|
      artist_songs << ArtistSong.new(artist_id: id, order: 123)
    end
  end
end
