class Track < ApplicationRecord
  belongs_to :song, optional: true
  belongs_to :record, optional: true

  has_one_attached :web_audio, dependent: :purge_later

  def title = "#{number}: #{song.human_full_title}"

  def duration
    metadata = web_audio.blob.try(:metadata)

    # mins, seconds = ms.divmod(60)
    # "#{mins}:#{seconds.round}"
    0
  end

  def assign_record(record_id)
    return unless record_id

    record = Record.find_by(record_id)
    record.tracks << self unless record.tracks.include?(self)
  end
end
