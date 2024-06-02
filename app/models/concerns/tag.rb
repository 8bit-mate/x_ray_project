# Concern for any model that can act as a 'tag'.
module Tag
  extend ActiveSupport::Concern

  included do
    translates :name
    translates :short_description
    translates :description

    friendly_id :name_en, use: :slugged

    scope :visible, -> { where(visible: true) }

    scope :sort_by_name, ->(ord = :asc) { i18n.order(name: ord) }
  end

  def should_generate_new_friendly_id?
    name_en_changed? || slug.blank?
  end

  def visiability
    visible ? "visible" : "invisible"
  end

  def span_class_name
    visible ? "badge text-bg-primary" : "badge text-bg-warning"
  end
end
