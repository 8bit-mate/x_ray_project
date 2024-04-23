class FormatTagRecord < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  belongs_to :format_tag
  belongs_to :record
end
