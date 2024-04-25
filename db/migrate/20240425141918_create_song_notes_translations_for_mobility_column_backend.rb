class CreateSongNotesTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :songs, :notes_en, :text
    add_index  :songs, :notes_en, name: :index_songs_on_notes_en
    add_column :songs, :notes_ru, :text
    add_index  :songs, :notes_ru, name: :index_songs_on_notes_ru
  end
end
