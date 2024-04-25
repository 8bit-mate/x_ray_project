class Artist < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag
end
