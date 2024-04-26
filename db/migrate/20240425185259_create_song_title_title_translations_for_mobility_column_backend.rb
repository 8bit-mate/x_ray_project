class CreateSongTitleTitleTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :song_titles, :title_en, :string
    add_index  :song_titles, :title_en, name: :index_song_titles_on_title_en
    add_column :song_titles, :title_ru, :string
    add_index  :song_titles, :title_ru, name: :index_song_titles_on_title_ru
  end
end
