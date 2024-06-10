class CreateSongGroupTitleTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :song_groups, :title_en, :string
    add_index  :song_groups, :title_en, name: :index_song_groups_on_title_en
    add_column :song_groups, :title_ru, :string
    add_index  :song_groups, :title_ru, name: :index_song_groups_on_title_ru
  end
end
