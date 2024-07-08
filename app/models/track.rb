class Track < ApplicationRecord
  validates :number, presence: true
  validates :song, presence: true

  belongs_to :song, counter_cache: :records_count
  belongs_to :record, optional: true, touch: true

  has_one_attached :web_audio, dependent: :purge_later

  scope :without_record_assigned, -> { where(record: nil) }

  delegate :artists, to: :song

  def self.ransackable_associations(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[record]
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[number]
    end
  end

  def title = "#{number}: #{song.human_full_title}"

  def duration
    metadata = web_audio.blob.try(:metadata) || {}

    return "" unless metadata.key? :duration

    ms = metadata[:duration].to_i
    mins, seconds = ms.divmod(60)

    format("%<mins>.2d:%<seconds>.2d", mins:, seconds: seconds.round)
  end

  def web_audio_key = web_audio.blob.try(:key)
end
