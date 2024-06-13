# Concern for any model that can act as a 'tag'.
module WithRecordsScope
  extend ActiveSupport::Concern

  included do
    scope :with_records, -> { where("records_count > ?", 0) }
  end
end
