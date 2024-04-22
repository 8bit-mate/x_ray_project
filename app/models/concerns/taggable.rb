# Concern for any model that can act as a 'tag'.
module Taggable
  extend ActiveSupport::Concern

  included do
    translates :name
    translates :short_description
    translates :description

    friendly_id :name_en, use: :slugged
  end

  def should_generate_new_friendly_id?
    name_en_changed? || slug.blank?
  end
end
