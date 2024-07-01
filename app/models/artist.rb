class Artist < ApplicationRecord
  extend Mobility
  extend FriendlyId

  validates :stage_name_en, presence: true
  validates :stage_name_ru, presence: true

  translates :stage_name
  translates :real_name
  translates :short_description
  translates :description

  friendly_id :stage_name_en, use: :slugged

  has_many :aliases,
           class_name: "Artist",
           foreign_key: "primary_artist_id",
           dependent: :nullify,
           inverse_of: :primary_artist
  belongs_to :primary_artist,
             class_name: "Artist",
             optional: true

  # Associations for when the artist is a band
  has_many :band_memberships,
           class_name: "ArtistBand",
           foreign_key: "band_id",
           dependent: :destroy,
           inverse_of: :artist
  has_many :members,
           through: :band_memberships,
           source: :artist,
           class_name: "Artist"

  # Associations for when the artist is a member of bands
  has_many :artist_bands, dependent: :destroy
  has_many :bands, through: :artist_bands, source: :band

  has_many :artist_songs, dependent: :destroy
  has_many :songs, through: :artist_songs

  has_many :main_songs,
           class_name: "Song",
           foreign_key: "main_artist_id",
           dependent: :nullify,
           inverse_of: :main_artist

  has_many :records, -> { distinct }, through: :songs

  after_update :update_associated_songs_full_titles

  scope :band_members, lambda {
    left_joins(:artist_bands)
      .where.not(artist_bands: { id: nil })
      .distinct
  }

  scope :bands, lambda {
    left_joins(:band_memberships)
      .where.not(band_memberships: { id: nil })
      .distinct
  }

  scope :aliases, -> { where.not(primary_artist_id: nil) }

  scope :primary_artists, -> { joins(:aliases).distinct }

  def self.ransackable_scopes(_auth_object = nil)
    %i[aliases bands band_members primary_artists]
  end

  def self.ransackable_associations(auth_object = nil)
    if auth_object == :admin
      super
    else
      []
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[stage_name real_name songs_count]
    end
  end

  # The artist is a band?
  def band? = members.count.positive?

  # The artist is a member of any band?
  def member? = bands.count.positive?

  # The artist is a root artist for aliases?
  def primary? = aliases.count.positive?

  # The artist is an alias for another artist?
  def alias? = primary_artist ? true : false

  private

  def should_generate_new_friendly_id?
    stage_name_en_changed? || slug.blank?
  end

  def update_associated_songs_full_titles
    songs.each(&:update_full_title)
  end
end
