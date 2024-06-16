class CreateArtistSongRoleTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :artist_songs, :role_en, :string, default: "", null: false
    add_index  :artist_songs, :role_en, name: :index_artist_songs_on_role_en
    add_column :artist_songs, :role_ru, :string, default: "", null: false
    add_index  :artist_songs, :role_ru, name: :index_artist_songs_on_role_ru
  end
end
