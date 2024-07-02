class CreateArtistBandRoleTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :artist_bands, :role_en, :string
    add_index  :artist_bands, :role_en, name: :index_artist_bands_on_role_en
    add_column :artist_bands, :role_ru, :string
    add_index  :artist_bands, :role_ru, name: :index_artist_bands_on_role_ru
  end
end
