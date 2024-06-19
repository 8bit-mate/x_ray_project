class Record < ApplicationRecord
  include AppendToHasManyAttached["web_images"]

  validates :category, presence: true
  validates :web_images, presence: true

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
      %w[category_id number updated_at]
    end
  end

  def create_or_update_tags(tags_params)
    create_or_update_category(tags_params[:category_id])
    create_or_update_label(tags_params[:label_id])
    create_or_delete_format_tags(tags_params[:format_tags_ids])
    create_or_delete_tracks(tags_params[:tracks_ids])
  end

  private

  def create_or_delete_tracks(tracks_ids)
    self.tracks = []

    return unless tracks_ids

    tracks_ids.each do |id|
      tracks << Track.find_by(id:)
    end
  end

  def create_or_delete_format_tags(format_tags_ids)
    format_tag_records.destroy_all

    return unless format_tags_ids

    format_tags_ids.each do |id|
      format_tags << FormatTag.find_by(id:)
    end
  end

  def create_or_update_category(id)
    return if id.nil?

    self.category = Category.find_by(id:)
  end

  def create_or_update_label(id)
    return if id.nil?

    self.label = Label.find_by(id:)
  end
end
