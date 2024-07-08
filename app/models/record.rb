class Record < ApplicationRecord
  include AppendToHasManyAttached["web_images"]
  extend FriendlyId
  attr_accessor :tags_attributes

  before_save :assign_cat_number

  friendly_id :compose_cat_number, use: :slugged

  validates :category, presence: true
  validates :label, presence: true
  validates :web_images, presence: true
  validates :format_size, presence: true
  # validate :format_tags_presence
  # validate :tracks_presence

  has_many_attached :web_images, dependent: :purge_later do |image|
    image.variant :preview, resize_to_limit: [300, 300]
  end

  belongs_to :category, counter_cache: :records_count
  belongs_to :label, counter_cache: :records_count

  has_many :format_tag_records, dependent: :destroy
  has_many :format_tags, through: :format_tag_records

  has_many :tracks, dependent: :nullify

  scope :without_category, -> { where(category_id: nil) }
  scope :without_label, -> { where(label_id: nil) }

  def self.ransackable_associations(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[category]
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[category_id cat_number format_size number updated_at]
    end
  end

  def create_or_update_tags
    create_or_update_format_tags(@tags_attributes[:format_tags_ids])
    create_or_update_tracks(@tags_attributes[:tracks_ids])
  end

  def compose_cat_number
    "#{category_short_name}-#{pad_format_size}#{pad_number}"
  end

  def assign_cat_number
    self.cat_number = compose_cat_number
  end

  def pad_number = format("%03d", number)

  def pad_format_size = format("%02d", format_size)

  def should_generate_new_friendly_id?
    cat_number_changed? || slug.blank?
  end

  private

  def format_tags_presence
    return if tags_attributes.present? && tags_attributes[:format_tags_ids].present?

    errors.add(:base, "At least one format tag should present")
  end

  def tracks_presence
    return if tags_attributes.present? && tags_attributes[:tracks_ids].present?

    errors.add(:base, "At least one track should present")
  end

  def category_short_name
    return unless category

    parts = category.name_en.split(" ", 2)

    select_letters(parts).join.upcase
  end

  def select_letters(parts)
    if parts.length == 2
      [parts[0][0], parts[1][0]]
    elsif parts.length == 1
      [parts[0][0], parts[0][1]]
    else
      ["??"]
    end
  end

  def create_or_update_tracks(tracks_ids)
    self.tracks = []

    return unless tracks_ids

    tracks_ids.uniq.each do |id|
      tracks << Track.find_by(id:)
    end
  end

  def create_or_update_format_tags(format_tags_ids)
    format_tag_records.destroy_all

    return unless format_tags_ids

    format_tags_ids.uniq.each do |id|
      format_tags << FormatTag.find_by(id:)
    end
  end
end
