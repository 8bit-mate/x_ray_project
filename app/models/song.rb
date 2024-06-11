class Song < ApplicationRecord
  extend Mobility
  extend FriendlyId

  friendly_id :compose_slug_title, use: :slugged

  translates :notes, :variation, :title

  has_many :artist_songs, dependent: :destroy
  has_many :artists, through: :artist_songs

  has_many :tracks, dependent: :destroy
  has_many :records, through: :tracks

  belongs_to :song_group
  belongs_to :main_artist, class_name: "Artist"

  scope :without_title, -> { where(song_group: nil) }
  scope :with_full_title, ->(title) { where(full_title: title) }

  def self.ransackable_associations(_auth_object = nil)
    %w[song_group artists main_artist]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[year_of_release title title_en title_ru]
  end

  def create_or_update_tags(tags_params)
    create_or_delete_artists(tags_params[:artists_slugs])
    create_or_delete_song_group(tags_params[:song_group_id])

    self.full_title = compose_full_title
  end

  def variation? = !variation_en.empty?

  def print_variation = variation? ? "(#{variation})" : ""

  def join_artists = list_artists.join("; ")

  def list_artists = artists.map(&:full_name)

  def human_full_title = "#{join_artists} - #{song_group.title}"

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
    variation = variation? ? " (#{variation_en})" : ""
    "#{names}-#{title_en}#{variation}"
  end

  def create_or_delete_song_group(id)
    return if id.nil?

    self.song_group = SongGroup.find_by(id:)
  end

  def create_or_delete_artists(slugs)
    artist_songs.destroy_all

    return unless slugs

    slugs.reject(&:empty?).each do |slug|
      artist = Artist.find_by(slug:)
      artists << artist
    end

    self.main_artist = artists.first
  end
end
