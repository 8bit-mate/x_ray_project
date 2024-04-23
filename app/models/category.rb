class Category < ApplicationRecord
  extend Mobility
  extend FriendlyId

  include Tag

  has_many :records, dependent: :destroy

  def frequency
    records.length
  end
end
