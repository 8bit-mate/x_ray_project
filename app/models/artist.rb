class Artist < ApplicationRecord
  extend Mobility
  extend FriendlyId

  translates :first_name
  translates :last_name
  translates :short_description
  translates :description

  friendly_id :full_name, use: :slugged

  # has_many :aliaces, class_name: "Artist", foreign_key: "primary_artist_id", dependent: :nullify, inverse_of: :primary_artist
  # belongs_to :primary_artist, class_name: "Artist", optional: true

  has_many :aliases, dependent: :destroy
  has_many :related_artists, through: :aliases

  has_many :artist_songs, dependent: :destroy
  has_many :songs, through: :artist_songs

  has_many :main_songs, class_name: "Song", foreign_key: "main_artist_id", dependent: :nullify, inverse_of: :main_artist

  has_many :records, -> { distinct }, through: :songs

  after_update :update_associated_songs_full_titles

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[first_name first_name_en first_name_ru last_name last_name_en last_name_ru songs_count]
  end

  def full_name(order = :last_name_first)
    order == :last_name_first ? "#{last_name}, #{first_name}" : "#{first_name} #{last_name}"
  end

  private

  def should_generate_new_friendly_id?
    first_name_en_changed? || last_name_en_changed? || slug.blank?
  end

  def update_associated_songs_full_titles
    songs.each(&:update_full_title)
  end
end
