class CreateArtistNameAndShortDescriptionAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :name_en, :string
    add_index  :artists, :name_en, name: :index_artists_on_name_en
    add_column :artists, :name_ru, :string
    add_index  :artists, :name_ru, name: :index_artists_on_name_ru
    add_column :artists, :short_description_en, :string
    add_index  :artists, :short_description_en, name: :index_artists_on_short_description_en
    add_column :artists, :short_description_ru, :string
    add_index  :artists, :short_description_ru, name: :index_artists_on_short_description_ru
    add_column :artists, :description_en, :text
    add_index  :artists, :description_en, name: :index_artists_on_description_en
    add_column :artists, :description_ru, :text
    add_index  :artists, :description_ru, name: :index_artists_on_description_ru
  end
end
