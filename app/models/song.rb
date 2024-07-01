class Song < ApplicationRecord
  extend Mobility
  extend FriendlyId
  include WithRecordsScope

  validates :song_group, presence: true

  friendly_id :compose_slug_title, use: :slugged

  translates :notes, :variation, :title

  has_many :artist_songs, dependent: :destroy, inverse_of: :song
  has_many :artists, through: :artist_songs
  accepts_nested_attributes_for :artist_songs, allow_destroy: true

  has_many :tracks, dependent: :destroy
  has_many :records, -> { distinct }, through: :tracks

  belongs_to :song_group
  belongs_to :main_artist, class_name: "Artist"

  scope :without_title, -> { where(song_group: nil) }
  scope :with_full_title, ->(title) { where(full_title: title) }

  def self.ransackable_associations(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[song_group artists artist_songs main_artist]
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[year_of_release title title_en title_ru records_count]
    end
  end

  def create_or_update_main_artist(song_params)
    # id = song_params[:artist_songs_attributes]["0"][:artist_id]
    id = song_params[:artist_songs_attributes].to_h.values[0][:artist_id]
    self.main_artist = Artist.find_by(id:)
  end

  def variation? = !variation_en.empty?

  def print_variation = variation? ? "(#{variation})" : ""

  def join_artists = list_artists.join("; ")

  def list_artists = artists.map(&:stage_name)

  def human_full_title = "#{join_artists} - #{song_group.title}"

  def should_generate_new_friendly_id?
    full_title_changed? || slug.blank? || variation_en_changed?
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
    names = artists.map(&:stage_name_en).join(" ")
    variation = variation? ? " (#{variation_en})" : ""
    "#{names}-#{title_en}#{variation}"
  end
end
