class Post < ApplicationRecord
  extend Mobility
  translates :body, backend: :action_text
  translates :title

  validates :title_en, presence: true
  validates :title_ru, presence: true
end
