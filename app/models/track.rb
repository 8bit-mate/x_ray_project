class Track < ApplicationRecord
  validates :number, presence: true
  validates :song, presence: true
  validates :record, presence: true

  belongs_to :song, counter_cache: :records_count
  belongs_to :record

  has_one_attached :web_audio, dependent: :purge_later

  scope :without_record_assigned, -> { where(record: nil) }

  delegate :artists, to: :song

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
