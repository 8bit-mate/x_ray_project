class Post < ApplicationRecord
  extend Mobility
  extend FriendlyId

  translates :body, backend: :action_text
  translates :title

  friendly_id :title_en, use: :slugged

  validates :title_en, presence: true
  validates :title_ru, presence: true

  def should_generate_new_friendly_id?
    title_en_changed? || slug.blank?
  end
end
