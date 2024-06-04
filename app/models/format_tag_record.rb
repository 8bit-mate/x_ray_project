class FormatTagRecord < ApplicationRecord
  belongs_to :format_tag, counter_cache: :records_count
  belongs_to :record
end
