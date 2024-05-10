class CreateSongVariationAndNotesTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :songs, :variation_en, :string, default: "", null: false
    add_index  :songs, :variation_en, name: :index_songs_on_variation_en
    add_column :songs, :variation_ru, :string, default: "", null: false
    add_index  :songs, :variation_ru, name: :index_songs_on_variation_ru

    add_column :songs, :notes_en, :text, default: "", null: false
    add_index  :songs, :notes_en, name: :index_songs_on_notes_en
    add_column :songs, :notes_ru, :text, default: "", null: false
    add_index  :songs, :notes_ru, name: :index_songs_on_notes_ru
  end
end
