class Post < ApplicationRecord
  extend Mobility
  extend FriendlyId

  translates :body, backend: :action_text
  translates :title

  friendly_id :title_en, use: :slugged

  validates :title_en, presence: true
  validates :title_ru, presence: true
  validates :body, presence: true

  def should_generate_new_friendly_id?
    title_en_changed? || slug.blank?
  end

  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin
      super
    else
      %w[id created_at updated_at title_en title_ru body]
    end
  end
end
