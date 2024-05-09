class FormatTag < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  has_many :format_tag_records, dependent: :destroy
  has_many :records, through: :format_tag_records

  def n_records_tagged
    records.uniq.length
  end
end
