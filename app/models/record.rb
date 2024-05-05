class Record < ApplicationRecord
  validates :category, presence: true

  has_many_attached :web_images

  belongs_to :category

  has_many :format_tag_records, dependent: :destroy
  has_many :format_tags, through: :format_tag_records

  has_many :record_tracks, dependent: :destroy
  has_many :tracks, through: :record_tracks

  scope :without_category, -> { where(category_id: nil) }

  def create_or_update_tags(tags_params)
    create_or_update_category(tags_params[:category_id])
    create_or_delete_format_tags(tags_params[:format_tags_ids])
    create_or_delete_tracks(tags_params[:tracks_ids])
  end

  private

  def create_or_delete_tracks(tracks_ids)
    record_tracks.destroy_all

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
end
