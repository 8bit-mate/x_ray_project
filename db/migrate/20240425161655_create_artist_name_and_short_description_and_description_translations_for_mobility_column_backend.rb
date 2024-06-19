class CreateArtistNameAndShortDescriptionAndDescriptionTranslationsForMobilityColumnBackend < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :stage_name_en, :string
    add_index  :artists, :stage_name_en, name: :index_artists_on_stage_name_en
    add_column :artists, :stage_name_ru, :string
    add_index  :artists, :stage_name_ru, name: :index_artists_on_stage_name_ru
    add_column :artists, :real_name_en, :string
    add_index  :artists, :real_name_en, name: :index_artists_on_real_name_en
    add_column :artists, :real_name_ru, :string
    add_index  :artists, :real_name_ru, name: :index_artists_on_real_name_ru
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
