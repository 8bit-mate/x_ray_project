class CreatePostTitleTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :title_en, :string
    add_index  :posts, :title_en, name: :index_posts_on_title_en
    add_column :posts, :title_ru, :string
    add_index  :posts, :title_ru, name: :index_posts_on_title_ru
  end
end
