class Song < ApplicationRecord
  extend Mobility
  extend FriendlyId

  friendly_id :compose_slug_title, use: :slugged

  scope :without_title, -> { where(song_title: nil) }
  scope :with_full_title, ->(title) { where(full_title: title) }

  translates :notes, :variation

  has_many :artist_songs, dependent: :destroy
  has_many :artists, through: :artist_songs

  has_many :tracks, dependent: :destroy
  has_many :records, through: :tracks

  belongs_to :song_title

  delegate :title, to: :song_title

  # scope :sorted_by_first_artist, -> { joins(:artists).order(first_name_en: :desc).uniq }

  #   scope :sorted_by_title, -> { Song.i18n.joins(:song_title).i18n.order("title_#{I18n.locale} desc") }

  scope :sort_by_title, ->(ord = :asc) { joins(:song_title).merge(SongTitle.sort_by_title(ord)) }
  scope :sort_by_year_of_release, ->(ord = :asc) { order(year_of_release: ord) }

  scope :sorted_by_first_artist, lambda {
    joins(:artists)
      .select("songs.*, MIN(artist_songs.id)")
      .group("songs.id")
      .order("first_name_#{I18n.locale} desc")
  }

  def records = tracks.map(&:record)

  def create_or_update_tags(tags_params)
    create_or_delete_artists(tags_params[:artists_slugs])
    create_or_delete_song_title(tags_params[:song_title_id])

    self.full_title = compose_full_title
  end

  # Return list of song's alternative versions, e.g. live versions,
  # alternative takes, or versions performed by other artists.
  def other_variations = song_title.songs.reject { |e| e == self }

  # Tell whether the song has other versions.
  def other_variations? = !other_variations.empty?

  def variation? = !variation_en.empty?

  def print_variation = variation? ? "(#{variation})" : ""

  def join_artists = list_artists.join("; ")

  def list_artists = artists.map(&:full_name)

  def human_full_title = "#{join_artists} - #{song_title.title}"

  def should_generate_new_friendly_id?
    full_title_changed? || slug.blank?
  end

  def update_full_title
    self.full_title = compose_full_title
    save
  end

  def self.ransackable_associations(_auth_object = nil)
    ["song_title"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["year_of_release"]
  end

  private

  def compose_slug_title
    n_songs_with_this_title = Song.with_full_title(full_title).length
    n_songs_with_this_title.zero? ? full_title : "#{full_title}-#{n_songs_with_this_title}"
  end

  def compose_full_title
    names = artists.map(&:full_name).join(" ")
    title = song_title.title_en
    variation = variation? ? " (#{variation_en})" : ""
    "#{names}-#{title}#{variation}"
  end

  def create_or_delete_song_title(id)
    return if id.nil?

    self.song_title = SongTitle.find_by(id:)
  end

  def create_or_delete_artists(slugs)
    artist_songs.destroy_all

    return unless slugs

    slugs.reject(&:empty?).each do |slug|
      artist = Artist.find_by(slug:)
      artists << artist
    end
  end
end
