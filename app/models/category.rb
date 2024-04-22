class Category < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Taggable

  has_many :records, dependent: :destroy
end
