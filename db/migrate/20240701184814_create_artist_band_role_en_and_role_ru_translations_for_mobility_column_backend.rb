class CreateArtistBandRoleEnAndRoleRuTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :artist_bands, :role_en_en, :string
    add_index  :artist_bands, :role_en_en, name: :index_artist_bands_on_role_en_en
    add_column :artist_bands, :role_en_ru, :string
    add_index  :artist_bands, :role_en_ru, name: :index_artist_bands_on_role_en_ru
    add_column :artist_bands, :role_ru_en, :string
    add_index  :artist_bands, :role_ru_en, name: :index_artist_bands_on_role_ru_en
    add_column :artist_bands, :role_ru_ru, :string
    add_index  :artist_bands, :role_ru_ru, name: :index_artist_bands_on_role_ru_ru
  end
end
