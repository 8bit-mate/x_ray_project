class Category < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  has_many :records, dependent: :destroy
end
