class Track < ApplicationRecord
  belongs_to :song

  has_one_attached :web_audio, dependent: :purge_later

  has_one :record_track, dependent: :destroy
  has_one :record, through: :record_track

  def title = "#{number}: #{song.human_full_title}"

  def assign_record(record_id)
    return unless record_id

    record = Record.find_by(record_id)
    record.tracks << self unless record.tracks.include?(self)
  end
end
